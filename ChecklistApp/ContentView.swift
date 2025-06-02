//
//  ContentView.swift
//  ChecklistApp
//
//  Created by Oliver Pinder on 30/05/2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            MyListsView()
                .tabItem {
                    Label("My Lists", systemImage: "checklist")
                }
            
            SearchView()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
            
            CreateListView()
                .tabItem {
                    Label("Create", systemImage: "plus.circle")
                }
            
            NotificationView()
                .tabItem {
                    Label("Notifications", systemImage: "bell")
                }
            
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gearshape")
                }
        }
    }
}

#Preview {
    ContentView()
}
