//
//  MyListsView.swift
//  ChecklistApp
//
//  Created by Oliver Pinder on 02/06/2025.
//

import SwiftUI

struct MyListsView: View {
    @State private var showingCreateList = false
    @EnvironmentObject var store: ChecklistStore

    var body: some View {
        NavigationView {
            VStack {
                if store.checklists.isEmpty {
                    Text("No lists yet!")
                        .font(.headline)
                        .foregroundColor(.gray)
                        .padding(.top, 40)
                    Spacer()
                } else {
                    List {
                        ForEach($store.checklists) { $checklist in
                            NavigationLink(destination: ChecklistDetailView(checklist: $checklist)) {
                                Text(checklist.title)
                            }
                        }
                    }
                }
            }
            .navigationTitle("My Lists")
            .navigationBarItems(trailing: Button("Create List") {
                showingCreateList.toggle()
            })
            .sheet(isPresented: $showingCreateList) {
                CreateListView { newChecklist in
                    store.add(newChecklist)
                }
            }
        }
    }
}

#Preview {
    MyListsView()
}
