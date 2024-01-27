//
//  DefaultVolumeContentView.swift
//  VolumeWindowZoom
//
//  Created by Drew Olbrich on 1/27/24.
//

import SwiftUI
import RealityKit

struct DefaultVolumeContentView: View {

    let defaultSize: Size3D
    
    var body: some View {
        RealityView { contents in
            let radius: Float = 0.5*Float(min(defaultSize.width, defaultSize.height, defaultSize.depth))
            
            let sphereEntity = SphereEntity(radius: radius, color: .systemOrange)
            contents.add(sphereEntity)
            
            let boxCornerEntity = BoxCornerEntity(size: defaultSize)
            contents.add(boxCornerEntity)
        }
    }
    
}
