//
//  ContentView.swift
//  OrangeTheorySwiftUI
//
//  Created by Nathan Molby on 2/4/25.
//

import SwiftUI

struct ContentView: View {
    @State var treadmillDataProvider: FakeTreadmillDataProvider = WorkoutTreadmillDataProvider(startDate: .now)
    @State var currentTime = Date.now
    
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
        .task {
            for await _ in Timer.publish(every: 1, on: .main, in: .common).autoconnect().values {
                currentTime = currentTime.addingTimeInterval(15)
                treadmillDataProvider.executeDataMeasurement(forTime: currentTime)
            }
        }
        .task {
            for await _ in Timer.publish(every: 1, on: .main, in: .common).autoconnect().values {
                treadmillDataProvider.executeHistoryDataMeasurement(forTime: currentTime)
            }
        }
    }
}

#Preview {
    ContentView()
}
