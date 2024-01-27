//
//  BoxCornerEntity.swift
//  VolumeWindowZoom
//
//  Created by Drew Olbrich on 1/27/24.
//

import RealityKit
import SwiftUI
import UIKit

class BoxCornerEntity: Entity {
    
    init(size: Size3D, lineLength: Float = 0.1, lineWidth: Float = 0.01) {
        super.init()

        var lineMaterial = PhysicallyBasedMaterial()
        lineMaterial.baseColor = .init(tint: .white)
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
                    var position = SIMD3<Float>(size.vector)/2
                    position.x *= xAxisSign
                    position.y *= yAxisSign
                    position.z *= zAxisSign
                    addCorner(at: position)
                }
            }
        }
    }
    
    @MainActor required init() {
        fatalError("init() has not been implemented")
    }
        
}
