//
//  ChecklistAppApp.swift
//  ChecklistApp
//
//  Created by Oliver Pinder on 30/05/2025.
//

import SwiftUI
import Foundation

@main
struct ChecklistAppApp: App {
    init() {
        // sets the background of the bottom tab to be orange
        let appearance = UITabBarAppearance()
        appearance.backgroundColor = UIColor(named: "Primary")

        // changes the colours of items in the tab
        let selectedColor = UIColor(red: 1, green: 0.984, blue: 0, alpha: 1) // #FFFB00
        let unselectedColor = UIColor { traitCollection in
            return traitCollection.userInterfaceStyle == .dark ? .black : .white
        }
        
        // should set the colour of all items to my yellow
        UIView.appearance().tintColor = UIColor(red: 1, green: 0.984, blue: 0, alpha: 1) // #FFFB00

        appearance.stackedLayoutAppearance.selected.iconColor = selectedColor
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: selectedColor]

        appearance.stackedLayoutAppearance.normal.iconColor = unselectedColor
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: unselectedColor]

        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
