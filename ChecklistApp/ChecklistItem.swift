//
//  ChecklistItem.swift
//  ChecklistApp
//
//  Created by Oliver Pinder on 02/06/2025.
//

import Foundation

struct ChecklistItem: Identifiable, Codable {
    var id = UUID()
    let title: String
    var isChecked: Bool
}
