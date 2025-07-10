//
//  ChecklistDetailView.swift
//  ChecklistApp
//
//  Created by Oliver Pinder on 04/06/2025.
//

import SwiftUI

struct ChecklistDetailView: View {
    @Binding var checklist: Checklist
    var onChecklistChange: () -> Void
    var onChecklistDelete: () -> Void
    @State private var isEditing = false
    @State private var newItemText = ""
    @State private var showDeleteListConfirmation = false

    private func deleteItems(at offsets: IndexSet) {
        if checklist.items.count == 1 && offsets.contains(0) {
            showDeleteListConfirmation = true
        } else {
            checklist.items.remove(atOffsets: offsets)
            onChecklistChange()
        }
    }
    
    private func addItem() {
        let trimmedText = newItemText.trimmingCharacters(in: .whitespaces)
        guard !trimmedText.isEmpty else { return }
        
        checklist.items.append(ChecklistItem(title: trimmedText, isChecked: false))
        newItemText = ""
        onChecklistChange()
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            if isEditing {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Tap below to edit list title:")
                        .font(.caption)
                        .foregroundColor(.gray)
                        .padding(.horizontal)

                    TextField("List Title", text: $checklist.title)
                        .font(.title3)
                        .foregroundColor(.gray)
                        .padding(.horizontal)
                        .onChange(of: checklist.title) {
                            onChecklistChange()
                        }
                }
                .transition(.move(edge: .top).combined(with: .opacity))
            }
            List {
                if isEditing {
                    Text("Swipe to delete items. Hold and Drag items to reorder. Tap to edit names")
                        .font(.footnote)
                        .foregroundColor(.gray)
                        .padding(.horizontal)
                        .padding(.bottom, 8)
                        .listRowInsets(EdgeInsets(top: 2, leading: 0, bottom: 0, trailing: 0))
                }
                ForEach($checklist.items) { $item in
                    if isEditing {
                        TextField("Item", text: $item.title)
                            .onChange(of: item.title) {
                                onChecklistChange()
                            }
                    } else {
                        Toggle(isOn: $item.isChecked) {
                            Text(item.title)
                        }
                        .onChange(of: item.isChecked) {
                            onChecklistChange()
                        }
                    }
                }
                .onDelete(perform: isEditing ? deleteItems : nil)
                .onMove { indices, newOffset in
                    checklist.items.move(fromOffsets: indices, toOffset: newOffset)
                    onChecklistChange()
                }
                
                if isEditing {
                    HStack {
                        TextField("Add new item", text: $newItemText)
                        Button("Add") {
                            addItem()
                        }
                    }
                }
                
                
            }
            .navigationTitle(checklist.title)
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button(isEditing ? "Done" : "Edit") {
                        withAnimation {
                            isEditing.toggle()
                        }
                    }
                    Button("Reset") {
                        for i in checklist.items.indices {
                            checklist.items[i].isChecked = false
                        }
                        onChecklistChange()
                    }
                }
            }
            .safeAreaInset(edge: .top) {
                Color.clear.frame(height: 8)
            }
        }
        .alert("Delete Entire List?", isPresented: $showDeleteListConfirmation) {
            Button("Delete", role: .destructive) {
                checklist.items.removeAll()
                onChecklistChange()
                onChecklistDelete()
            }
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("Deleting this item will also delete the entire list")
        }
    }
}


#Preview {
    ChecklistDetailView(checklist: .constant(Checklist(
        title: "Packing List",
        items: [
            ChecklistItem(title: "Toothbrush", isChecked: false),
            ChecklistItem(title: "Socks", isChecked: true),
            ChecklistItem(title: "Charger", isChecked: false)
        ]
    )),
    onChecklistChange: {},
    onChecklistDelete: {})
}

