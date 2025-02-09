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
                
                HStack(spacing: 100) {
                    MetricView(metricWithUnit: configuration.formatLength(dataProvider.currentDistance), label: .init(localized: "Distance"))
                    
                    MetricView(metricWithUnit: configuration.formatTime(dataProvider.timeSinceStart), label: .init(localized: "Time"), icon: .init(systemName: "stopwatch"))
                }
            }
        }
    }
}

#Preview(traits: .landscapeLeft) {
    TreadmillView()
}
