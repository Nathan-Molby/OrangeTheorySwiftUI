//
//  ContentView.swift
//  OrangeTheorySwiftUI
//
//  Created by Nathan Molby on 2/4/25.
//

import SwiftUI

struct ContentView: View {
    @State var treadmillDataProvider: FakeTreadmillDataProvider = WorkoutTreadmillDataProvider(startDate: .now)
    @State var biometricDataProvider: FakeBiometricsDataProvider = WorkoutBiometricsDataProvider(startDate: .now)
    
    @State var currentTime = Date.now
    @State var timeSpeedFactor = 1.0
    @State var configuration = Configuration()
    
    var body: some View {
        TabView {
            Tab("Treadmill", systemImage: "figure.run") {
                TreadmillView()
                    .environment(\.treadmillDataProvider, treadmillDataProvider)
                    .environment(\.biometricDataProvider, biometricDataProvider)
            }
            
            Tab("Settings", systemImage: "gearshape") {
                ConfigurationView(configuration: $configuration, timeSpeedFactor: $timeSpeedFactor)
            }
        }
        .environment(\.configuration, configuration)
        .preferredColorScheme(.dark)
        .task(id: timeSpeedFactor) {
            for await _ in Timer.publish(every: 1 / timeSpeedFactor, tolerance: 0.001, on: .main, in: .common).autoconnect().values {
                currentTime = currentTime.addingTimeInterval(1)
                treadmillDataProvider.executeDataMeasurement(forTime: currentTime)
                biometricDataProvider.executeDataMeasurement(forTime: currentTime)

                treadmillDataProvider.executeHistoryDataMeasurement(forTime: currentTime)
                biometricDataProvider.executeHistoryDataMeasurement(forTime: currentTime)

            }
        }
        .onAppear {
            UISegmentedControl.appearance().setTitleTextAttributes(
                [
                    .font: UIFont.systemFont(ofSize: 25),
                ], for: .normal)
        }
    }
}

#Preview(traits: .landscapeLeft) {
    ContentView()
}
