//
//  ContentView.swift
//  OrangeTheorySwiftUI
//
//  Created by Nathan Molby on 2/4/25.
//

import SwiftUI

struct ContentView: View {
    @State var treadmillDataProvider: TreadmillDataProvider = StaticTreadmillDataProvider(incline: .init(value: 2, unit: .incline), speed: .init(value: 6, unit: .milesPerHour))
    
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
    }
}

#Preview {
    ContentView()
}
