//
//  TreadmillView.swift
//  OrangeTheorySwiftUI
//
//  Created by Nathan Molby on 2/4/25.
//

import SwiftUI

struct TreadmillView: View {
    @Environment(\.treadmillDataProvider) var dataProvider
    @Environment(\.configuration) var configuration
    
    var body: some View {
        HStack {
            // TODO: Heart Rate View
            Color.gray
                .frame(width: 400)
            
            Spacer()
            
            VStack(spacing: 40) {
                // TODO: Logo
                Text("OTConnect")
                    .font(.largest)
                
                HStack {
                    Spacer()
                    
                    MetricView(metricWithUnit: configuration.formatLength(dataProvider.currentDistance), label: .init(localized: "Distance"), icon: .init(systemName: "arrow.triangle.swap"))
                    
                    Spacer()
                    
                    MetricView(metricWithUnit: configuration.formatTime(dataProvider.timeSinceStart), label: .init(localized: "Time"), icon: .init(systemName: "stopwatch"))
                    
                    Spacer()
                }
                .addProgressTracker(progress: configuration.formatTrackPercentage(dataProvider.currentDistance))
                
                HStack(spacing: 20) {
                    GraphView(metricBySecond: configuration.formatIncline(dataProvider.inclineHistory), averageBySecond: configuration.calculateAndFormatInclineAverage(dataProvider.inclineHistory), configuration: .init(scale: 0...16, yMarkers: [5, 10, 15], formatAsPercentage: true))
                    
                    GraphView(metricBySecond: configuration.formatSpeed(dataProvider.speedHistory), averageBySecond: configuration.calculateAndFormatSpeedAverage(dataProvider.speedHistory), configuration: .init(scale: 0...13, yMarkers: [3, 6, 9, 12], formatAsPercentage: false))

                }
            }
        }
    }
}

#Preview(traits: .landscapeLeft) {
    TreadmillView()
}
