//
//  SettingsView.swift
//  ChecklistApp
//
//  Created by Oliver Pinder on 02/06/2025.
//

import SwiftUI

struct SettingsView: View {

    @State var showResetConfirmation: Bool = false
    @EnvironmentObject var store: ChecklistStore

    var body: some View {
        NavigationView {
            ZStack {
                Color("AppBackground").ignoresSafeArea()
                List {
                    Section("Reset") {
                        Button("Reset Checklists") {
                            showResetConfirmation = true
                        }
                        .alert(isPresented: $showResetConfirmation) {
                            Alert(title: Text("Are you sure?"), message: Text("This will remove all your checklists and items."), primaryButton: .destructive(Text("Reset"), action: {
                                store.reset()
                            }), secondaryButton: .cancel())
                        }
                    }
                }
                .navigationTitle(Text("Settings"))
            }
            .scrollContentBackground(.hidden)
        }
    }
}

#Preview {
    SettingsView()
}
