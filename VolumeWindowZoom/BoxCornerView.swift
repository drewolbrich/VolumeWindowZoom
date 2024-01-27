//
//  BoxCornerView.swift
//  VolumeWindowZoom
//
//  Created by Drew Olbrich on 1/27/24.
//

import SwiftUI
import RealityKit

/// A view that displays the corners of a box, automatically scaled to fit
/// `defaultSize`, taking the user's Window Zoom preference into account.
struct BoxCornerView: View {
    
    let defaultSize: Size3D

    @State private var boxCornerEntity: Entity?

    var body: some View {
        GeometryReader3D { proxy in
            RealityView { content in
                let boxCornerEntity = BoxCornerEntity(size: defaultSize)
                self.boxCornerEntity = boxCornerEntity
                scaleEntity(boxCornerEntity, with: content, for: proxy, defaultSize: defaultSize)
                content.add(boxCornerEntity)
            } update: { content in
                if let boxCornerEntity {
                    scaleEntity(boxCornerEntity, with: content, for: proxy, defaultSize: defaultSize)
                }
            }
        }
    }
    
    private func scaleEntity(_ entity: Entity, with content: RealityViewContent, for proxy: GeometryProxy3D, defaultSize: Size3D) {
        let scaledVolumeContentBoundingBox = content.convert(proxy.frame(in: .local), from: .local, to: .scene)
        let scale = scaledVolumeContentBoundingBox.extents.x/Float(defaultSize.width)
        entity.scale = [1, 1, 1]*scale
    }

}
