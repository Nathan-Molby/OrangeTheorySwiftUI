//
//  ContentView.swift
//  OrangeTheorySwiftUI
//
//  Created by Nathan Molby on 2/4/25.
//

import SwiftUI

struct ContentView: View {
    @State var treadmillDataProvider: TreadmillDataProvider = PreviewTreadmillDataProvider()
    
    var body: some View {
        TabView {
            Tab("Treadmill", systemImage: "figure.run") {
                TreadmillView()
                    .environment(\.treadmillDataProvider, treadmillDataProvider)
            }
            
            Tab("Rower", systemImage: "figure.rower") {
                Text("Rower TODO")
            }
            
            Tab("Settings", systemImage: "gearshape") {
                Text("Settings TODO")
            }
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView()
}
