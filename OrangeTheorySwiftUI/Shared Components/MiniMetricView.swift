//
//  MiniMetricView.swift
//  OrangeTheorySwiftUI
//
//  Created by Nathan Molby on 2/23/25.
//

import SwiftUI

struct MiniMetricView: View {
    let metric: MetricWithUnit
    let label: String
    
    var body: some View {
        HStack(spacing: 12) {
            Text(label)
                .foregroundStyle(Color.metricGray)
                .font(.small.bold())
            
            Text(metric.metric)
                .foregroundStyle(.white)
                .font(.medium.bold().italic())
                .padding(.bottom, 2)
        }
    }
}

#Preview {
    MiniMetricView(metric: .init(metric: "1.2", unit: "%"), label: "AVG")
}
