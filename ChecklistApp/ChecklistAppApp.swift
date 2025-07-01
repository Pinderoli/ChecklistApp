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
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(red: 247/255, green: 127/255, blue: 0/255, alpha: 1)
        
        appearance.stackedLayoutAppearance.selected.iconColor = UIColor(red: 255/255, green: 251/255, blue: 0/255, alpha: 1)
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor(red: 255/255, green: 251/255, blue: 0/255, alpha: 1)]
        
        appearance.stackedLayoutAppearance.normal.iconColor = .white
        appearance.stackedLayoutAppearance.normal.iconColor = .white
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
        
        let navAppearance = UINavigationBarAppearance()
        navAppearance.configureWithOpaqueBackground()
        navAppearance.backgroundColor = UIColor(red: 247/255, green: 127/255, blue: 0/255, alpha: 1)

        navAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]

        UINavigationBar.appearance().standardAppearance = navAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navAppearance
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .tint(Color(red: 255/255, green: 251/255, blue: 0/255))
        }
    }
}


