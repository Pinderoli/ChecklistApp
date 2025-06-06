//
//  MyListsView.swift
//  ChecklistApp
//
//  Created by Oliver Pinder on 02/06/2025.
//

import SwiftUI

struct MyListsView: View {
    
    @State private var showingCreateList = false
    @State private var checklists: [Checklist] = []
    
    private let checklistsKey = "SavedChecklists"
    
    var body: some View {
        NavigationView {
            VStack {
                if checklists.isEmpty {
                    Text("No lists yet!")
                        .font(.headline)
                        .foregroundColor(.gray)
                        .padding(.top, 40)
                    Spacer()
                } else {
                    List {
                        ForEach($checklists) { $checklist in
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
                    checklists.append(newChecklist)
                    saveChecklists()
                }
            }
            .onAppear {
                loadChecklists()
            }
        }
    }
    
    // MARK: - Persistence
    
    private func saveChecklists() {
        if let encoded = try? JSONEncoder().encode(checklists) {
            UserDefaults.standard.set(encoded, forKey: checklistsKey)
        }
    }

    private func loadChecklists() {
        if let savedData = UserDefaults.standard.data(forKey: checklistsKey),
           let decoded = try? JSONDecoder().decode([Checklist].self, from: savedData) {
            checklists = decoded
        }
    }
}

#Preview {
    MyListsView()
}
