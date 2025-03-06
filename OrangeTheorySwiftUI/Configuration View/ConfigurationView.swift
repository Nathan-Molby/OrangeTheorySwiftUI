//
//  ConfigurationView.swift
//  OrangeTheorySwiftUI
//
//  Created by Nathan Molby on 3/5/25.
//

import SwiftUI

struct ConfigurationView: View {
    @Binding var configuration: Configuration
    
    /// The speed at which time moves. 1 = 1 second / real second. 5 = 5 seconds / real second
    @Binding var timeSpeedFactor: Double
    @State var trackLength: Double = 0.5
    
    var maxTrackLength: Double {
        switch configuration.lengthUnit {
        case .mile, .kilometer:
            return 1
        case .meter:
            return 1000
        case .furlong:
            return 10
        }
    }
    
    var body: some View {
        Form {
            Section {
                Picker("Length Unit", selection: $configuration.lengthUnit) {
                    ForEach(SupportedLengthUnit.allCases) { lengthUnit in
                        Text(lengthUnit.displayName)
                    }
                }
            } header: {
                Text("Length Unit")
                    .font(.small)
            }
            
            Section {
                Picker("Speed Unit", selection: $configuration.speedUnit) {
                    ForEach(SupportedSpeedUnit.allCases) { speedUnit in
                        Text(speedUnit.displayName)
                    }
                }
            } header: {
                Text("Speed Unit")
                    .font(.small)
            }
            
            Section {
                Picker("Incline Unit", selection: $configuration.inclineUnit) {
                    ForEach(SupportedAngleUnit.allCases) { inclineUnit in
                        Text(inclineUnit.displayName)
                    }
                }
            } header: {
                Text("Incline Unit")
                    .font(.small)
            }
            
            
            Section {
                VStack {
                    let lengthUnitSymbol = configuration.lengthUnit.unitLength.symbol
                    
                    Slider(value: $trackLength, in: 0...maxTrackLength, step: maxTrackLength / 10) {
                        Text("Track Distance")
                    } minimumValueLabel: {
                        Text("0 \(lengthUnitSymbol)")
                    } maximumValueLabel: {
                        Text("\(maxTrackLength.formatted()) \(lengthUnitSymbol)")
                    }
                    
                    Text("\(trackLength.formatted()) \(lengthUnitSymbol)")
                }
            } header: {
                Text("Track Distance")
                    .font(.small)
            }
            
            Section {
                VStack {
                    Slider(value: $configuration.chartWidthMinutes, in: 1...60, step: 1.0) {
                        Text("Chart Width")
                    } minimumValueLabel: {
                        Text("1 Minute")
                    } maximumValueLabel: {
                        Text("60 Minutes")
                    }
                    
                    Text("\(configuration.chartWidthMinutes.formatted()) Minutes")
                }
            } header: {
                Text("Chart Width")
                    .font(.small)
            }
            
            Section {
                VStack {
                    Slider(value: $timeSpeedFactor, in: 1...60, step: 1.0) {
                        Text("Time Speed")
                    } minimumValueLabel: {
                        Text("1 Second")
                    } maximumValueLabel: {
                        Text("60 Seconds")
                    }
                    
                    Text("\(timeSpeedFactor.formatted()) Seconds")
                }
            } header: {
                Text("Time Speed")
                    .font(.small)
            }
        }
        .pickerStyle(.segmented)
        .onAppear {
            trackLength = configuration.trackDistance.value
        }
        .onChange(of: configuration.lengthUnit) { oldValue, newValue in
            trackLength = Measurement(value: trackLength, unit: oldValue.unitLength).converted(to: newValue.unitLength).value
            trackLength = min(trackLength, maxTrackLength)
        }
        .onChange(of: trackLength) {
            configuration.trackDistance = .init(value: trackLength, unit: configuration.lengthUnit.unitLength)
        }
    }
}

#Preview {
    @Previewable @State var configuration = Configuration()
    @Previewable @State var timeSpeedFactor = 5.0
    ConfigurationView(configuration: $configuration, timeSpeedFactor: $timeSpeedFactor)
        .onAppear {
            UISegmentedControl.appearance().setTitleTextAttributes(
                [
                    .font: UIFont.systemFont(ofSize: 25),
                ], for: .normal)
        }
}
