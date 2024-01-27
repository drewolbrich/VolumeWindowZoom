//
//  ScaledBoxVolumeContentView.swift
//  VolumeWindowZoom
//
//  Created by Drew Olbrich on 1/27/24.
//

import SwiftUI
import RealityKit

/// A view that displays a blue sphere in a `RealityView`.
///
/// This view is decorated with `ResponsiveBoxCornersEntity`, which highlights the
/// corners of the RealityView's volume.
///
/// When the sphere is created, it is sized to fit exactly within `defaultSize`,
/// which must correspond to the value passed to the volumetric window group's
/// `defaultSize(_:in:)` view modifier.
///
/// In this view, `GeometryReader3D` is used to dynamically adapt the size of the
/// sphere to reflect the user's Window Zoom preference.
struct ScaledBoxVolumeContentView: View {

    let defaultSize: Size3D
    
    /// A root entity added to the `RealityView`.
    ///
    /// This entity is automatically scaled to reflect changes to the user's selected
    /// Window Zoom preference.
    @State private var scaledRootEntity = Entity()
    
    @State private var responsiveBoxCornersEntity = ResponsiveBoxCornersEntity()
    
    var body: some View {
        GeometryReader3D { proxy in
            RealityView { content in
                let radius: Float = 0.5*Float(min(defaultSize.width, defaultSize.height, defaultSize.depth))

                content.add(scaledRootEntity)
                scale(entity: scaledRootEntity, with: content, for: proxy, defaultSize: defaultSize)

                let sphereEntity = SphereEntity(radius: radius, color: .systemBlue)
                scaledRootEntity.addChild(sphereEntity)

                // Decorate the corners of the volume so we can tell how large the volume is.
                responsiveBoxCornersEntity.make(with: content, for: proxy, defaultSize: defaultSize)
                content.add(responsiveBoxCornersEntity)
            } update: { content in
                // When the user selects a new Window Zoom preference, we scale the contents of the
                // volume to reflect its new size.
                //
                // We don't necessarily have to scale the contents of the volume. Depending on the
                // needs of the application, it might be more appropriate want to align the
                // volume's contents with the edge of the volume or display a different amount of
                // content.
                //
                // However, because in visionOS 1.0 volumes aren't resizable by the user (aside
                // from by changing Window Zoom), scaling the contents of the volume most likely
                // matches the developer's expectations.
                scale(entity: scaledRootEntity, with: content, for: proxy, defaultSize: defaultSize)

                // When the user selects a new Window Zoom preference, we update the positions of
                // the volume's corner decorations the reflect the new size of the volume.
                responsiveBoxCornersEntity.update(with: content, for: proxy)
            }
        }
    }
    
    /// Sets the scale of `entity` to reflect the user's Window Zoom preference, as
    /// selected by the user in the Settings app under Display > Appearance > Window Zoom.
    ///
    /// It is assumed that `entity` is positioned at the origin of a volumetric window
    /// group. 
    ///
    /// `defaultSize` must be equal to the value passed to the volumetric window group's
    /// `defaultSize(_:in:)` view modifier when it was first created.
    ///
    /// This method must be called by both the `make` and `update` closures of the
    /// volume's `RealityView`.
    func scale(entity: Entity, with content: RealityViewContent, for proxy: GeometryProxy3D, defaultSize: Size3D) {
        /// The size of the volume, scaled to reflect the selected Window Zoom.
        let scaledVolumeSize = content.convert(proxy.frame(in: .local), from: .local, to: .scene)

        /// The user's selected Window Zoom scale factor, as ratio between the displayed
        /// size of the volume and the size specified by `defaultSize` when the volume was
        /// originally defined.
        let scale = scaledVolumeSize.extents.x/Float(defaultSize.width)

        entity.scale = .one*scale
    }

}
