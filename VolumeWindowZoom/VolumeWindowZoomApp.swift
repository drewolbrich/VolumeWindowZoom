//
//  VolumeWindowZoomApp.swift
//  VolumeWindowZoom
//
//  Created by Drew Olbrich on 1/27/24.
//

import SwiftUI

@main
struct VolumeWindowZoomApp: App {

    /// The size of the volumes presented by the app.
    let defaultSize = Size3D(width: 0.5, height: 0.5, depth: 0.5)

    var body: some Scene {
        WindowGroup {
            // A view with three buttons that open each of the volumes below.
            ContentView()
        }
        .windowResizability(.contentSize)
        
        WindowGroup(id: "default-volume") {
            // A view containing a red sphere that fits within `defaultSize`.
            DefaultVolumeContentView(defaultSize: defaultSize)
        }
        .windowStyle(.volumetric)
        .defaultSize(defaultSize, in: .meters)

        WindowGroup(id: "unscaled-volume") {
            // A view containing a red sphere and the corners of a box of size `defaultSize`.
            UnscaledBoxVolumeContentView(defaultSize: defaultSize)
        }
        .windowStyle(.volumetric)
        .defaultSize(defaultSize, in: .meters)

        WindowGroup(id: "scaled-volume") {
            // A view containing a blue sphere and the corners of a box of size `defaultSize`.
            // If the user changes their Window Zoom preference in the settings app, the blue
            // sphere is adaptively scaled to reflect changes in the size of the volume.
            ScaledBoxVolumeContentView(defaultSize: defaultSize)
        }
        .windowStyle(.volumetric)
        .defaultSize(defaultSize, in: .meters)
    }
    
}
