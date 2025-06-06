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

    var body: some View {
        List {
            ForEach($checklist.items) { $item in
                Toggle(isOn: $item.isChecked) {
                    Text(item.title)
                }
                .onChange(of: item.isChecked) {
                    onChecklistChange()
                }
            }
        }
        .navigationTitle(checklist.title)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Reset") {
                    for i in checklist.items.indices {
                        checklist.items[i].isChecked = false
                    }
                }
            }
        }
    }
}


//#Preview {
//    ChecklistDetailView()
//}
