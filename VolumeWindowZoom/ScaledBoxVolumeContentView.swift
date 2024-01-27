//
//  ScaledBoxVolumeContentView.swift
//  VolumeWindowZoom
//
//  Created by Drew Olbrich on 1/27/24.
//

import SwiftUI
import RealityKit

struct ScaledBoxVolumeContentView: View {

    let defaultSize: Size3D
    
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

                responsiveBoxCornersEntity.make(with: content, for: proxy, defaultSize: defaultSize)
                content.add(responsiveBoxCornersEntity)
            } update: { content in
                scale(entity: scaledRootEntity, with: content, for: proxy, defaultSize: defaultSize)

                responsiveBoxCornersEntity.update(with: content, for: proxy, defaultSize: defaultSize)
            }
        }
    }
    
    func scale(entity: Entity, with content: RealityViewContent, for proxy: GeometryProxy3D, defaultSize: Size3D) {
        let scaledVolumeContentBoundingBox = content.convert(proxy.frame(in: .local), from: .local, to: .scene)
        let scale = scaledVolumeContentBoundingBox.extents.x/Float(defaultSize.width)
        entity.scale = [1, 1, 1]*scale
    }

}
