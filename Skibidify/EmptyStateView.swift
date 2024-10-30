//
//  EmptyStateView.swift
//  Skibidify
//
//  Created by Jia Chen Yee on 10/30/24.
//

import Foundation
import SwiftUI

struct EmptyStateView: View {
    
    @Binding var isImagePlaygroundPresented: Bool
    
    var body: some View {
        ContentUnavailableView {
            Label("create a skibidi", systemImage: "toilet.fill")
        } description: {
            Text("get started and create your first skibidi!")
        } actions: {
            Button("skibidify", systemImage: "apple.image.playground") {
                isImagePlaygroundPresented = true
            }
            .buttonStyle(.borderedProminent)
        }
    }
}

#Preview {
    @Previewable @State var isImagePlaygroundPresented: Bool = false
    EmptyStateView(isImagePlaygroundPresented: $isImagePlaygroundPresented)
}
