//
//  Checklist.swift
//  ChecklistApp
//
//  Created by Oliver Pinder on 04/06/2025.
//

import Foundation

enum ChecklistType: String, Codable, CaseIterable {
    case simple = "Simple"
    case tabbed = "Tabbed"
    case procedural = "Procedural"
}

struct Checklist: Identifiable, Encodable, Decodable {
    var id = UUID()
    var title: String
    var items: [ChecklistItem]
    var tabs: [ChecklistTab]? = nil
    var type: ChecklistType = .simple
}

struct ChecklistTab: Identifiable, Codable {
    var id = UUID()
    var title: String
    var items: [ChecklistItem]
}
