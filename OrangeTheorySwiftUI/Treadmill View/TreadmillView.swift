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
                    
                    MetricWithIconView(metricWithUnit: configuration.formatLength(dataProvider.currentDistance), label: .init(localized: "Distance"), icon: .init(systemName: "arrow.triangle.swap"))
                    
                    Spacer()
                    
                    MetricWithIconView(metricWithUnit: configuration.formatTime(dataProvider.timeSinceStart), label: .init(localized: "Time"), icon: .init(systemName: "stopwatch"))
                    
                    Spacer()
                }
                .addProgressTracker(progress: configuration.formatTrackPercentage(dataProvider.currentDistance))
                
                HStack(spacing: 20) {
                    VStack {
                        MetricView(metric: configuration.formatIncline(dataProvider.currentIncline), label: "INCLINE")
                        
                        GraphView(metricBySecond: configuration.formatInclineForGraph(dataProvider.inclineHistory), averageBySecond: configuration.calculateInclineAverageForGraph(dataProvider.inclineHistory), configuration: .init(yMarkers: configuration.inclineYAxis, yMarkerSuffix: configuration.inclineUnit.unitAngle.symbol))
                        
                        MiniMetricView(metric: configuration.formatIncline(dataProvider.averageIncline), label: "AVG")
                    }

                    VStack {
                        MetricView(metric: configuration.formatSpeed(dataProvider.currentSpeed), label: configuration.speedUnit.unitSpeed.symbol)
        
                        
                        GraphView(metricBySecond: configuration.formatSpeedForGraph(dataProvider.speedHistory), averageBySecond: configuration.calculateSpeedAverageForGraph(dataProvider.speedHistory), configuration: .init(yMarkers: configuration.speedYAxis, yMarkerSuffix: nil))
                        
                        HStack {
                            MiniMetricView(metric: configuration.formatPace(at: dataProvider.currentSpeed), label: "PACE")
                        }

                    }
                }
            }
        }
    }
}

#Preview(traits: .landscapeLeft) {
    TreadmillView()
}
