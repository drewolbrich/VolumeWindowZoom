//
//  SphereEntity.swift
//  VolumeWindowZoom
//
//  Created by Drew Olbrich on 1/27/24.
//

import RealityKit
import UIKit

/// An entity that draws a sphere.
///
/// Both the exterior and interior surfaces are represented.
class SphereEntity: Entity {

    init(radius: Float, color: UIColor) {
        super.init()
        
        var hue: CGFloat = 0
        var saturation: CGFloat = 1
        var brightness: CGFloat = 1
        color.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: nil)
        let interiorColor = UIColor(hue: hue, saturation: saturation*0.6, brightness: brightness*0.5, alpha: 1)
        
        let sphereMesh = MeshResource.generateSphere(radius: radius)
        
        var exteriorMaterial = PhysicallyBasedMaterial()
        exteriorMaterial.baseColor = .init(tint: color)
        exteriorMaterial.metallic = .init(floatLiteral: 0.2)
        exteriorMaterial.roughness = .init(floatLiteral: 0.3)
        
        let exteriorModelEntity = ModelEntity(mesh: sphereMesh, materials: [exteriorMaterial])

        // Setting `CollisionComponent` and `InputTargetComponent` allows the user to
        // assign the focus to the volume containing the sphere by selecting it.
        let collisionShape = ShapeResource.generateSphere(radius: radius)
        exteriorModelEntity.components.set(CollisionComponent(shapes: [collisionShape]))
        exteriorModelEntity.components.set(InputTargetComponent())
        
        addChild(exteriorModelEntity)

        var interiorMaterial = PhysicallyBasedMaterial()
        interiorMaterial.faceCulling = .front
        interiorMaterial.baseColor = .init(tint: interiorColor)
        interiorMaterial.roughness = .init(floatLiteral: 1)
        
        let interiorModelEntity = ModelEntity(mesh: sphereMesh, materials: [interiorMaterial])
        
        addChild(interiorModelEntity)
    }
    
    @MainActor required init() {
        fatalError("init() has not been implemented")
    }
    
}
