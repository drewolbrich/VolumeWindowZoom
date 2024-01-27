//
//  VolumeWindowZoomApp.swift
//  VolumeWindowZoom
//
//  Created by Drew Olbrich on 1/27/24.
//

import SwiftUI

@main
struct VolumeWindowZoomApp: App {
    
    let defaultSize = Size3D(width: 0.5, height: 0.5, depth: 0.5)

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .windowResizability(.contentSize)
        
        WindowGroup(id: "default-volume") {
            DefaultVolumeContentView(defaultSize: defaultSize)
        }
        .windowStyle(.volumetric)
        .defaultSize(defaultSize, in: .meters)

        WindowGroup(id: "unscaled-volume") {
            UnscaledBoxVolumeContentView(defaultSize: defaultSize)
        }
        .windowStyle(.volumetric)
        .defaultSize(defaultSize, in: .meters)

        WindowGroup(id: "scaled-volume") {
            ScaledBoxVolumeContentView(defaultSize: defaultSize)
        }
        .windowStyle(.volumetric)
        .defaultSize(defaultSize, in: .meters)
    }
    
}
