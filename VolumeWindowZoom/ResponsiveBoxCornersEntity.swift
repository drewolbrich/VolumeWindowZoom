//
//  ResponsiveBoxCornersEntity.swift
//  VolumeWindowZoom
//
//  Created by Drew Olbrich on 1/27/24.
//

import RealityKit
import SwiftUI
import UIKit

/// An entity that draws the corners of a box in a wireframe style, and which can
/// automatically resize itself to volume size changes that occur when the user
/// changes their Window Zoom preference in the visionOS Settings app.
class ResponsiveBoxCornersEntity: Entity {
    
    func make(with content: RealityViewContent, for proxy: GeometryProxy3D, defaultSize: Size3D, lineLength: Float = 0.1, lineWidth: Float = 0.01, color: UIColor = .white) {
        // `make` should not be called twice.
        assert(children.isEmpty)
        
        var lineMaterial = PhysicallyBasedMaterial()
        lineMaterial.baseColor = .init(tint: color)
        lineMaterial.roughness = .init(floatLiteral: 1)
        
        func addCorner(at position: SIMD3<Float>) {
            let cornerDirection: SIMD3<Float> = [sign(position.x), sign(position.y), sign(position.z)]
            
            for axis in 0 ..< 3 {
                var lineSize: SIMD3<Float> = [lineWidth, lineWidth, lineWidth]
                lineSize[axis] = lineLength
                let lineMesh = MeshResource.generateBox(size: lineSize)
                let lineModelEntity = ModelEntity(mesh: lineMesh, materials: [lineMaterial])
                lineModelEntity.position = position - cornerDirection*lineSize/2
                
                addChild(lineModelEntity)
            }
        }
        
        for xAxisSign: Float in [-1, 1] {
            for yAxisSign: Float in [-1, 1] {
                for zAxisSign: Float in [-1, 1] {
                    var position = SIMD3<Float>(defaultSize.vector)/2
                    position.x *= xAxisSign
                    position.y *= yAxisSign
                    position.z *= zAxisSign
                    addCorner(at: position)
                }
            }
        }
        
        update(with: content, for: proxy, defaultSize: defaultSize)
    }
    
    func update(with content: RealityViewContent, for proxy: GeometryProxy3D, defaultSize: Size3D) {
        let scaledVolumeContentBoundingBox = content.convert(proxy.frame(in: .local), from: .local, to: .scene)
        let scale = scaledVolumeContentBoundingBox.extents.x/Float(defaultSize.width)
        self.scale = [1, 1, 1]*scale
    }
    
}
