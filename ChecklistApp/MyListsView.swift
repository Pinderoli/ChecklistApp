//
//  MyListsView.swift
//  ChecklistApp
//
//  Created by Oliver Pinder on 02/06/2025.
//

import SwiftUI

struct MyListsView: View {
    @State private var items = [
        ChecklistItem(title: "Buy milk", isChecked: false),
        ChecklistItem(title: "Socks", isChecked: false),
        ChecklistItem(title: "Phone Charger", isChecked: false)
    ]
    
    var body: some View {
        NavigationView {
            List {
                ForEach($items) { $item in
                    Toggle(isOn: $item.isChecked) {
                        Text(item.title)
                    }
                }
            }
            .navigationTitle("My Lists")
        }
    }
}
