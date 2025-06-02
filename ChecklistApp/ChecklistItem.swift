//
//  ChecklistItem.swift
//  ChecklistApp
//
//  Created by Oliver Pinder on 02/06/2025.
//

import Foundation

struct ChecklistItem: Identifiable {
    let id = UUID()
    let title: String
    var isChecked: Bool
}
