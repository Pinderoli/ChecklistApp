//
//  ChecklistStore.swift
//  ChecklistApp
//
//  Created by Marc Pinder on 06/06/2025.
//


import Foundation
import SwiftUI

class ChecklistStore: ObservableObject {
    @Published var checklists: [Checklist] = []
    
    private let checklistsKey = "SavedChecklists"
    
    init() {
        load()
    }
    
    func load() {
        if let savedData = UserDefaults.standard.data(forKey: checklistsKey),
           let decoded = try? JSONDecoder().decode([Checklist].self, from: savedData) {
            checklists = decoded
        }
    }
    
    func save() {
        if let encoded = try? JSONEncoder().encode(checklists) {
            UserDefaults.standard.set(encoded, forKey: checklistsKey)
        }
    }
    
    func reset() {
        checklists.removeAll()
        UserDefaults.standard.removeObject(forKey: checklistsKey)
        save() // ensures observers see the update
    }

    func add(_ checklist: Checklist) {
        checklists.append(checklist)
        save()
    }
}
