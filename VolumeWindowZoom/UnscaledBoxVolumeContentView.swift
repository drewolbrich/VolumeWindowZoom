//
//  UnscaledBoxVolumeContentView.swift
//  VolumeWindowZoom
//
//  Created by Drew Olbrich on 1/27/24.
//

import SwiftUI
import RealityKit

/// A view that displays a red sphere in a `RealityView`.
///
/// This view is decorated with `ResponsiveBoxCornersEntity`, which highlights the
/// corners of the RealityView's volume.
///
/// When the sphere is created, it is sized to fit exactly within `defaultSize`,
/// which must correspond to the value passed to the volumetric window group's
/// `defaultSize(_:in:)` view modifier.
///
/// When the user changes their Window Zoom preference in the Settings app,
/// `GeometryReader3D` is used to adjust the size of `ResponsiveBoxCornersEntity` to
/// match the new size of the volume.
///
/// In this view, `GeometryReader3D` is not used to change the size of the sphere,
/// so it will appear clipped or padded depending on the Window Zoom preference.
struct UnscaledBoxVolumeContentView: View {

    let defaultSize: Size3D
    
    /// A decorative entity used to highlight the corners of the volume.
    @State private var responsiveBoxCornersEntity = ResponsiveBoxCornersEntity()
    
    var body: some View {
        GeometryReader3D { proxy in
            RealityView { content in
                let radius: Float = 0.5*Float(min(defaultSize.width, defaultSize.height, defaultSize.depth))
                
                let sphereEntity = SphereEntity(radius: radius, color: .systemRed)
                content.add(sphereEntity)

                // Decorate the corners of the volume so we can tell how large the volume is.
                responsiveBoxCornersEntity.make(with: content, for: proxy, defaultSize: defaultSize)
                content.add(responsiveBoxCornersEntity)
            } update: { content in
                // When the user selects a new Window Zoom preference, update the positions of the
                // volume's corner decorations the reflect the new size of the volume.
                responsiveBoxCornersEntity.update(with: content, for: proxy)
            }
        }
    }

}
