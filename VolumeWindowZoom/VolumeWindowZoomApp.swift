//
//  VolumeWindowZoomApp.swift
//  VolumeWindowZoom
//
//  Created by Drew Olbrich on 1/27/24.
//

import SwiftUI

@main
struct VolumeWindowZoomApp: App {
    
    let volumeDefaultSize = Size3D(width: 0.5, height: 0.5, depth: 0.5)

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .windowResizability(.contentSize)
        
        WindowGroup(id: "default-volume") {
            DefaultVolumeContentView(defaultSize: volumeDefaultSize)
        }
        .windowStyle(.volumetric)
        .defaultSize(volumeDefaultSize, in: .meters)

        WindowGroup(id: "scaled-volume") {
            ScaledVolumeContentView(defaultSize: volumeDefaultSize)
        }
        .windowStyle(.volumetric)
        .defaultSize(volumeDefaultSize, in: .meters)
    }
    
}
