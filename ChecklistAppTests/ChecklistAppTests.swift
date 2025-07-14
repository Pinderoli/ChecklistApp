//
//  ChecklistAppTests.swift
//  ChecklistAppTests
//
//  Created by Oliver Pinder on 30/05/2025.
//

import Testing
@testable import ChecklistApp

struct ChecklistAppTests {

    @Test func example() async throws {
        // Write your test here and use APIs like `#expect(...)` to check expected conditions.
    }

    @Test("ChecklistItem initial values")
    func checklistItemInitialValues() async throws {
        let item = ChecklistItem(title: "Sample Task", isChecked: false)
        #expect(item.title == "Sample Task")
        #expect(item.isChecked == false)
    }

    @Test("ChecklistItem toggling isChecked")
    func checklistItemToggleChecked() async throws {
        var item = ChecklistItem(title: "Toggle Task", isChecked: false)
        item.isChecked.toggle()
        #expect(item.isChecked == true)
    }

    @Test("Checklist adding item")
    func checklistAddItem() async throws {
        var checklist = Checklist(title: "Groceries", items: [])
        let item = ChecklistItem(title: "Eggs", isChecked: false)
        checklist.items.append(item)
        #expect(checklist.items.count == 1)
        #expect(checklist.items[0].title == "Eggs")
    }

    @Test("Checklist removing item")
    func checklistRemoveItem() async throws {
        var checklist = Checklist(title: "Groceries", items: [
            ChecklistItem(title: "Eggs", isChecked: false),
            ChecklistItem(title: "Milk", isChecked: false)
        ])
        checklist.items.remove(at: 0)
        #expect(checklist.items.count == 1)
        #expect(checklist.items[0].title == "Milk")
    }

    @Test("Checklist reset all items to unchecked")
    func checklistResetAllItems() async throws {
        var checklist = Checklist(title: "Packing", items: [
            ChecklistItem(title: "Socks", isChecked: true),
            ChecklistItem(title: "Shirt", isChecked: true)
        ])
        for i in checklist.items.indices {
            checklist.items[i].isChecked = false
        }
        #expect(checklist.items.allSatisfy { !$0.isChecked })
    }
}
