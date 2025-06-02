//
//  Checklist.swift
//  ChecklistApp
//
//  Created by Oliver Pinder on 04/06/2025.
//

import Foundation

struct Checklist: Identifiable {
    let id = UUID()
    var title: String
    var items: [ChecklistItem]
}
