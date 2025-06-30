//
//  ChooseListTypeView.swift
//  ChecklistApp
//
//  Created by Oliver Pinder on 26/06/2025.
//

import SwiftUI

struct ChooseListTypeView: View {
    
    @State private var navigateToSimpleList: Bool = false
    var onFinish: (() -> Void)?
    var onSave: ((Checklist) -> Void)?
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Spacer(minLength: 50)
                
                Text("Choose List Type")
                    .font(.title)
                
                Spacer(minLength: 20)
                
                Button("Simple List") {
                    navigateToSimpleList = true
                }
                
//                Button("Tabbed List (To Be Added)") {
//                    print("Not implemented yet")
//                }
//                
//                Button("Procedural List (To Be Added)") {
//                    print("Not implemented yet")
//                }

                Button("More list types coming soon ...") {}
                    .disabled(true)
                
                Spacer()
            }
            
            .navigationDestination(isPresented: $navigateToSimpleList) {
                CreateSimpleListView(
                    onSave: onSave,
                    onFinish: {
                        onFinish?()
                    }
                )
            }
        }
    }
}

#Preview {
    ChooseListTypeView()
}
