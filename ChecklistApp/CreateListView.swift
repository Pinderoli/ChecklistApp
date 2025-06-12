//
//  CreateListView.swift
//  ChecklistApp
//
//  Created by Oliver Pinder on 02/06/2025.
//

import SwiftUI

struct CreateListView: View {
    @Environment(\.dismiss) var dismiss
    @State private var newItem = ""
    @State private var items: [String] = []
    @State private var listTitle = ""

    var onsave: ((Checklist) -> Void)?
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("AppBackground").ignoresSafeArea()
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
                .scrollContentBackground(.hidden)
                .navigationTitle("Create List")
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancel") {
                            dismiss()
                        }
                    }
                    
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Done") {
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
