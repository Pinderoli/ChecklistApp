//
//  CreateTabbedListView.swift
//  ChecklistApp
//
//  Created by Oliver Pinder on 14/07/2025.
//

import SwiftUI

struct CreateTabbedListView: View {
    var onSave: ((Checklist) -> Void)?
    var onFinish: (() -> Void)?

    var body: some View {
        Text("Create Tabbed List - Coming Soon")
            .navigationTitle("Create Tabbed List")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") {
                        onFinish?()
                    }
                }
            }
    }
}

#Preview {
    CreateTabbedListView()
}
