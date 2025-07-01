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
                .padding(.vertical, 10)
                .padding(.horizontal, 16)
                .background(Color(red: 247/255, green: 127/255, blue: 0/255))
                .cornerRadius(12)

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
