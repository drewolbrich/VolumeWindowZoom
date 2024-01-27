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
    
    @State private var responsiveBoxCornersEntity = ResponsiveBoxCornersEntity()
    
    var body: some View {
        GeometryReader3D { proxy in
            RealityView { content in
                let radius: Float = 0.5*Float(min(defaultSize.width, defaultSize.height, defaultSize.depth))
                
                let sphereEntity = SphereEntity(radius: radius, color: .systemRed)
                content.add(sphereEntity)

                responsiveBoxCornersEntity.make(with: content, for: proxy, defaultSize: defaultSize)
                content.add(responsiveBoxCornersEntity)
            } update: { content in
                responsiveBoxCornersEntity.update(with: content, for: proxy, defaultSize: defaultSize)
            }
        }
    }
    
}
