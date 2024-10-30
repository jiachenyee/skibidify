//
//  GridImageView.swift
//  Skibidify
//
//  Created by Jia Chen Yee on 10/30/24.
//

import Foundation
import SwiftUI

struct GridImageView: View {
    
    var namespace: Namespace.ID
    var url: URL
    
    var body: some View {
        NavigationLink {
            VStack {
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .navigationTransition(.zoom(sourceID: url, in: namespace))
                Spacer()
            }
            .toolbar {
                ShareLink("Share", item: url)
            }
        } label: {
            AsyncImage(url: url) { image in
                image
                    .resizable()
                    .scaledToFit()
            } placeholder: {
                ProgressView()
            }
            .matchedTransitionSource(id: url, in: namespace)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.thickMaterial)
            .clipShape(.rect(cornerRadius: 8))
        }
    }
}

#Preview {
    @Previewable @Namespace var namespace
    
    GridImageView(namespace: namespace, url: .documentsDirectory)
}
