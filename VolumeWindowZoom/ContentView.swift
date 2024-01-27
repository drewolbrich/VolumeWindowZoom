//
//  ContentView.swift
//  VolumeWindowZoom
//
//  Created by Drew Olbrich on 1/27/24.
//

import SwiftUI
import RealityKit

struct ContentView: View {
    
    @Environment(\.openWindow) var openWindow
    
    var body: some View {
        VStack(spacing: 40) {
            Button("Open Default Volume") {
                openWindow(id: "default-volume")
            }
            Button("Open Unscaled Volume") {
                openWindow(id: "unscaled-volume")
            }
            Button("Open Scaled Volume") {
                openWindow(id: "scaled-volume")
            }
        }
        .padding(60)
    }
    
}
