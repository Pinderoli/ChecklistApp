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
    
    private func deleteChecklists(at offsets: IndexSet) {
        store.checklists.remove(atOffsets: offsets)
        store.save()
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("AppBackground").ignoresSafeArea()
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
                                NavigationLink(destination: ChecklistDetailView(checklist: $checklist, onChecklistChange: store.save)) {
                                    Text(checklist.title)
                                }
                            }
                            .onDelete(perform: deleteChecklists)
                        }
                        .scrollContentBackground(.hidden)
                    }
                }
            }
            .navigationTitle("My Lists")
            .navigationBarItems(
                leading: EditButton(),
                trailing: Button("Create List") {
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
