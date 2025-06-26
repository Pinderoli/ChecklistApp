//
//  CreateSimpleListView.swift
//  ChecklistApp
//
//  Created by Oliver Pinder on 02/06/2025.
//

import SwiftUI

struct CreateSimpleListView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var store: ChecklistStore
    @State private var newItem = ""
    @State private var items: [String] = []
    @State private var listTitle = ""
    @State private var showDuplicateTitleAlert: Bool = false
    @State private var showMissingItemAlert: Bool = false

    var onSave: ((Checklist) -> Void)?
    var onFinish: (() -> Void)?
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("List title", text: $listTitle)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                HStack {
                    TextField("New item", text: $newItem)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Button("Add") {
                        addItem()
                    }
                    .disabled(newItem.trimmingCharacters(in: .whitespaces).isEmpty)
                }
                .padding()

                List {
                    ForEach(items, id: \.self) { item in
                        Text(item)
                    }
                }

                Spacer()
            }
            .navigationTitle("Create List")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }

                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") {
                        guard !items.isEmpty else {
                            showMissingItemAlert = true
                            return
                        }
                        let trimmedTitle = listTitle.trimmingCharacters(in: .whitespacesAndNewlines)
                        var finalTitle = trimmedTitle
                        
                        if finalTitle.isEmpty {
                            let existingTitles = store.checklists.map { $0.title }
                            
                            if !existingTitles.contains("Untitled List") {
                                finalTitle = "Untitled List"
                            } else {
                                var number = 1
                                while existingTitles.contains("Untitled List (\(number))") {
                                    number += 1
                                }
                                finalTitle = "Untitled List (\(number))"
                            }
                        }
                        
                        if store.checklists.contains(where: { $0.title == finalTitle}) {
                            showDuplicateTitleAlert = true
                            return
                        }
                        
                        let checklist = Checklist(
                            title: finalTitle,
                            items: items.map { ChecklistItem(title: $0, isChecked: false) }
                        )
                        onSave?(checklist)
                        onFinish?()
                        dismiss()
                    }
                }
            }
        }
        .alert("Missing Items", isPresented: $showMissingItemAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text("Please add an item to the list.")
        }
        .alert("Duplicate List Name", isPresented: $showDuplicateTitleAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text("A list with this name already exists. Please choose a different name.")
        }
    }

    func addItem() {
        let trimmed = newItem.trimmingCharacters(in: .whitespaces)
        guard !trimmed.isEmpty else { return }
        items.append(trimmed)
        newItem = ""
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

#Preview {
    CreateSimpleListView()
        .environmentObject(ChecklistStore())
}
