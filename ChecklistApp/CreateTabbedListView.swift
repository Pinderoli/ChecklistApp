//
//  CreateTabbedListView.swift
//  ChecklistApp
//
//  Created by Oliver Pinder on 02/06/2025.
//

import SwiftUI

struct CreateTabbedListView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var store: ChecklistStore
    struct Tab {
        var title: String
        var items: [String]
    }
    
    @State private var tabs: [Tab] = []
    @State private var selectedTabIndex: Int? = nil
    @State private var newTabTitle: String = ""
    @State private var newItem: String = ""
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
                if let selectedIndex = selectedTabIndex {
                    HStack {
                        TextField("New Item", text: $newItem)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        Button("Add") {
                            let trimmed = newItem.trimmingCharacters(in: .whitespaces)
                            guard !trimmed.isEmpty else { return }
                            tabs[selectedIndex].items.append(trimmed)
                            newItem = ""
                            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                        }
                        .disabled(newItem.trimmingCharacters(in: .whitespaces).isEmpty)
                    }
                    .padding()
                }
                
                ScrollView(.horizontal, showsIndicators: true) {
                    HStack {
                        ForEach(tabs.indices, id: \.self) { index in
                            Button(action: {
                                selectedTabIndex = index
                            }) {
                                Text(tabs[index].title)
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 8)
                                    .background(selectedTabIndex == index ? Color.orange.opacity(0.2) : Color.gray.opacity(0.1))
                                    .cornerRadius(8)
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                
                HStack {
                    TextField("New Tab Title", text: $newTabTitle)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Button("Add Tab") {
                        let trimmed = newTabTitle.trimmingCharacters(in: .whitespaces)
                        guard !trimmed.isEmpty else { return }
                        tabs.append(Tab(title: trimmed, items: []))
                        selectedTabIndex = tabs.count - 1
                        newTabTitle = ""
                    }
                }

                if let selectedIndex = selectedTabIndex {
                    List {
                        ForEach(tabs[selectedIndex].items, id: \.self) { item in
                            
                            Text(item)
                        }
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
                        let allItems = tabs.flatMap { $0.items }
                        
                        guard !allItems.isEmpty else {
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

                        if store.checklists.contains(where: { $0.title == finalTitle }) {
                            showDuplicateTitleAlert = true
                            return
                        }

                        let checklistItems = allItems.map { ChecklistItem(title: $0, isChecked: false) }

                        let checklist = Checklist(
                            title: finalTitle,
                            items: checklistItems,
                            type: .tabbed
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
        if let index = selectedTabIndex {
            tabs[index].items.append(trimmed)
        }
        newItem = ""
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

#Preview {
    CreateTabbedListView()
        .environmentObject(ChecklistStore())
}
