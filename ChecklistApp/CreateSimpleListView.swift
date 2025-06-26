//
//  CreateSimpleListView.swift
//  ChecklistApp
//
//  Created by Oliver Pinder on 02/06/2025.
//

import SwiftUI

struct CreateSimpleListView: View {
    @Environment(\.dismiss) var dismiss
    @State private var newItem = ""
    @State private var items: [String] = []
    @State private var listTitle = ""
    @State private var showMissingItemAlert: Bool = false

    var onsave: ((Checklist) -> Void)?
    
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
                        let checklist = Checklist(
                            title: listTitle.isEmpty ? "Untitled List" : listTitle,
                            items: items.map { ChecklistItem(title: $0, isChecked: false) }
                        )
                        onsave?(checklist)
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
    }

    func addItem() {
        let trimmed = newItem.trimmingCharacters(in: .whitespaces)
        guard !trimmed.isEmpty else { return }
        items.append(trimmed)
        newItem = ""
    }
}

#Preview {
    CreateListView()
}
