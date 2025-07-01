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

    @State private var editingChecklistIndex: Int? = nil
    @State private var editingTitle: String = ""

    private func deleteChecklists(at offsets: IndexSet) {
        store.checklists.remove(atOffsets: offsets)
        store.save()
    }
    
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
                        ForEach(store.checklists.indices, id: \.self) { index in
                            let checklist = store.checklists[index]
                            NavigationLink(destination: ChecklistDetailView(
                                checklist: $store.checklists[index],
                                onChecklistChange: store.save,
                                onChecklistDelete: {
                                    if let idx = store.checklists.firstIndex(where: { $0.id == checklist.id }) {
                                        store.checklists.remove(at: idx)
                                        store.save()
                                    }
                                }
                            )) {
                                Text(checklist.title)
                            }
                            .swipeActions(edge: .leading) {
                                Button {
                                    editingChecklistIndex = index
                                    editingTitle = checklist.title
                                } label: {
                                    Label("Edit", systemImage: "pencil")
                                }
                                .tint(.blue)
                            }
                        }
                        .onDelete(perform: deleteChecklists)
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
                ChooseListTypeView(
                    onFinish: {
                        showingCreateList = false
                    },
                    onSave: { newChecklist in
                        store.add(newChecklist)
                    }
                )
            }
            .sheet(isPresented: Binding(get: { editingChecklistIndex != nil }, set: { if !$0 { editingChecklistIndex = nil } })) {
                NavigationView {
                    Form {
                        Section(header: Text("Edit List Title")) {
                            TextField("List Name", text: $editingTitle)
                        }
                    }
                    .navigationTitle("Edit List")
                    .toolbar {
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Save") {
                                let index = editingChecklistIndex!
                                store.checklists[index].title = editingTitle.trimmingCharacters(in: .whitespacesAndNewlines)
                                store.save()
                                editingChecklistIndex = nil
                            }
                            .disabled(editingTitle.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                        }
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Cancel") { editingChecklistIndex = nil }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    MyListsView()
}
