//
//  DefaultVolumeContentView.swift
//  VolumeWindowZoom
//
//  Created by Drew Olbrich on 1/27/24.
//

import SwiftUI
import RealityKit

/// A view that displays a red sphere in a `RealityView`.
///
/// When the sphere is created, it is sized to fit exactly within `defaultSize`,
/// which should correspond to the value passed to the volumetric window group's
/// `defaultSize(_:in:)` view modifier.
///
/// Because `GeometryReader3D` is not used, if this view is placed in a volume and
/// the user changes their Window Zoom preference in the Settings app, the sphere
/// may be clipped if the volume is too small or surrounded by extra padding if the
/// volume is too large.
struct DefaultVolumeContentView: View {
    
    let defaultSize: Size3D
    
    var body: some View {
        RealityView { content in
            let radius: Float = 0.5*Float(min(defaultSize.width, defaultSize.height, defaultSize.depth))
            
            let sphereEntity = SphereEntity(radius: radius, color: .systemRed)
            content.add(sphereEntity)
        }
    }
    
}
