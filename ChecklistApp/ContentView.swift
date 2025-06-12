//
//  ContentView.swift
//  ChecklistApp
//
//  Created by Oliver Pinder on 30/05/2025.
//

import SwiftUI

struct ContentView: View {

    @StateObject private var store = ChecklistStore()

    var body: some View {
        ZStack {
            
            TabView {
                MyListsView()
                    .tabItem {
                        Label("My Lists", systemImage: "checklist")
                    }
                    .environmentObject(store)
                
                NotificationView()
                    .tabItem {
                        Label("Notifications", systemImage: "bell")
                    }
                
                SettingsView()
                    .tabItem {
                        Label("Settings", systemImage: "gearshape")
                    }
                    .environmentObject(store)
            }
        }
    }
}

#Preview {
    ContentView()
}
