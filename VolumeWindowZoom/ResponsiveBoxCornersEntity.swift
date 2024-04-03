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

    private var lineLength: Float = 0
    
    private var lineWidth: Float = 0
    
    private var color: UIColor = .magenta
    
    /// This method must be called from the RealityView's `make` closure.
    func make(with content: RealityViewContent, for proxy: GeometryProxy3D, lineLength: Float = 0.08, lineWidth: Float = 0.006, color: UIColor = .white) {
        // `make` should not be called twice.
        assert(children.isEmpty)
        
        self.lineLength = lineLength
        self.lineWidth = lineWidth
        self.color = color
        
        addCorners(with: content, for: proxy)
    }
    
    /// This method must be called from the RealityView's `update` closure.
    func update(with content: RealityViewContent, for proxy: GeometryProxy3D) {
        // `make(with:for:defaultSize:lineLength:lineWidth:color:)` must have been called first.
        assert(!children.isEmpty)

        children.removeAll()
        
        addCorners(with: content, for: proxy)
    }
    
    private func addCorners(with content: RealityViewContent, for proxy: GeometryProxy3D) {
        let size = content.convert(proxy.frame(in: .local), from: .local, to: .scene).extents

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
                    var position = size/2
                    position.x *= xAxisSign
                    position.y *= yAxisSign
                    position.z *= zAxisSign
                    addCorner(at: position)
                }
            }
        }
    }
    
}
