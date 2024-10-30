//
//  ContentView.swift
//  Skibidify
//
//  Created by Jia Chen Yee on 10/30/24.
//

import SwiftUI
import ImagePlayground

struct ContentView: View {
    
    @State private var isImagePlaygroundPresented = false
    
    @State private var brainrot = Brainrot()
    
    @Namespace var namespace
    let columns = [GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        NavigationStack {
            switch brainrot.state {
            case .fetchingBrainrot:
                ProgressView()
            case .retrievedBrainrot(let imageURLs):
                if imageURLs.isEmpty {
                    EmptyStateView(isImagePlaygroundPresented: $isImagePlaygroundPresented)
                } else {
                    ZStack {
                        ScrollView {
                            LazyVGrid(columns: columns) {
                                ForEach(imageURLs, id: \.self) { imageURL in
                                    GridImageView(namespace: namespace, url: imageURL)
                                        .contextMenu {
                                            ShareLink("Share", item: imageURL)
                                            Button("Delete", systemImage: "trash", role: .destructive) {
                                                brainrot.deleteImage(url: imageURL)
                                            }
                                        }
                                }
                            }
                        }
                        Button("new", systemImage: "toilet.fill") {
                            isImagePlaygroundPresented = true
                        }
                        .buttonBorderShape(.roundedRectangle)
                        .buttonStyle(.borderedProminent)
                        .frame(maxHeight: .infinity, alignment: .bottom)
                        .padding()
                    }
                    .navigationTitle("my skibidis")
                }
            }
        }
        .imagePlaygroundSheet(isPresented: $isImagePlaygroundPresented, concepts: [
            .text("toilet bowl"),
            .text("spinning"),
            .text("person")
        ]) { url in
            try? FileManager.default.moveItem(at: url, to: .documentsDirectory.appendingPathComponent("skibidis/\(UUID().uuidString).png"))
            
            Task {
                await brainrot.fetchImages()
            }
        }
    }
}

#Preview {
    ContentView()
}
