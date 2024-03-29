//
//  VolumeWindowZoomApp.swift
//  VolumeWindowZoom
//
//  Created by Drew Olbrich on 1/27/24.
//

import SwiftUI

/// A visionOS app that demonstrates how to use `GeometryReader3D` to scale the
/// contents of a volumetric window group to reflect the user's Window Zoom
/// preference as selected in the Settings app.
///
/// In the visionOS Settings app, the Display > Appearance > Window Zoom preference
/// (with options Small, Medium, Large, and Extra Large) scales the size of the
/// windows and volumes presented by visionOS. However, it only automatically scales
/// the contents of windows, not volumes.
///
/// When a Window Zoom value other than Large (the default value) is selected, it's
/// the app's responsibility to use `GeometryReader3D` to scale or reposition the
/// contents of the volume to compensate for the new size of the volume.
///
/// If an app doesn't use `GeometryReader3D`, the volume's contents will be clipped
/// to the edge of the volume when Window Zoom is Small or Medium, or will exhibit
/// excessive padding when Window Zoom is Extra Large.
@main
struct VolumeWindowZoomApp: App {

    /// The size of the volumes presented by the app, measured in meters.
    let defaultSize = Size3D(width: 0.5, height: 0.5, depth: 0.5)

    var body: some Scene {
        WindowGroup {
            // A view with three buttons that open each of the volumes defined below.
            ContentView()
        }
        .windowResizability(.contentSize)
        
        WindowGroup(id: "default-volume", for: String.self) { value in
            // A view containing a red sphere that fits within `defaultSize`.
            DefaultVolumeContentView(defaultSize: defaultSize)
        }
        .windowStyle(.volumetric)
        .defaultSize(defaultSize, in: .meters)

        WindowGroup(id: "unscaled-volume", for: String.self) { value in
            // A view containing a red sphere and highlighted corners of a box of size
            // `defaultSize`.
            UnscaledBoxVolumeContentView(defaultSize: defaultSize)
        }
        .windowStyle(.volumetric)
        .defaultSize(defaultSize, in: .meters)

        WindowGroup(id: "scaled-volume", for: String.self) { value in
            // A view containing a blue sphere and highlighted corners of a box of size
            // `defaultSize`. If the user changes their Window Zoom preference in the Settings
            // app, the sphere is adaptively scaled to reflect changes in the size of the
            // volume.
            ScaledBoxVolumeContentView(defaultSize: defaultSize)
        }
        .windowStyle(.volumetric)
        .defaultSize(defaultSize, in: .meters)
    }
    
}
