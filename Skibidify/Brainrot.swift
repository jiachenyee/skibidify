//
//  Brainrot.swift
//  Skibidify
//
//  Created by Jia Chen Yee on 10/30/24.
//

import Foundation
import Observation
import SwiftUI

@MainActor
@Observable
class Brainrot {
    var state: AppState = .fetchingBrainrot
    
    var savedDirectory: URL {
        URL.documentsDirectory.appendingPathComponent("skibidis")
    }
    
    init() {
        if !FileManager.default.fileExists(atPath: savedDirectory.path()) {
            try? FileManager.default.createDirectory(at: savedDirectory, withIntermediateDirectories: true)
        }
        
        Task {
            await fetchImages()
        }
    }
    
    func fetchImages() async {
        do {
            let contents = try FileManager.default.contentsOfDirectory(at: savedDirectory,
                                                                       includingPropertiesForKeys: [])
            
            let images = contents.filter { url in
                url.pathExtension == "png"
            }
            
            withAnimation {
                state = .retrievedBrainrot(images)
            }
        } catch {
            withAnimation {
                state = .retrievedBrainrot([])
            }
        }
    }
    
    func deleteImage(url: URL) {
        try? FileManager.default.removeItem(at: url)
        
        Task {
            await fetchImages()
        }
    }
}

enum AppState {
    case fetchingBrainrot
    case retrievedBrainrot([URL])
}
