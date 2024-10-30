//
//  SkibidifyApp.swift
//  Skibidify
//
//  Created by Jia Chen Yee on 10/30/24.
//

import SwiftUI

@main
struct SkibidifyApp: App {
    
    @Environment(\.supportsImagePlayground) var supportsImagePlayground
    
    var body: some Scene {
        WindowGroup {
            if supportsImagePlayground {
                ContentView()
            } else {
                Text("Image Playground is not supported on this device.")
                    .multilineTextAlignment(.center)
            }
        }
    }
}
