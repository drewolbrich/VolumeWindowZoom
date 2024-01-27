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

    var body: some View {
        GeometryReader { proxy in
            RealityView { content in                
                let boxCornerEntity = BoxCornerEntity(size: defaultSize)
                content.add(boxCornerEntity)
            } update: { content in
                
            }
        }
    }
    
}
