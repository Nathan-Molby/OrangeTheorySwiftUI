//
//  MetricView.swift
//  OrangeTheorySwiftUI
//
//  Created by Nathan Molby on 2/23/25.
//

import SwiftUI

struct MetricView: View {
    let metric: MetricWithUnit
    let label: String
    
    var body: some View {
        HStack(alignment: .firstTextBaseline, spacing: 12) {
            Text(metric.metric)
                .foregroundStyle(.white)
                .font(.large.bold().italic())
                .padding(.bottom, 2)
            
            Text(label)
                .foregroundStyle(Color.metricGray)
                .font(.mediumLight.bold().italic())
            

        }
    }
}

#Preview {
    MetricView(metric: .init(metric: "1.2", unit: "%"), label: "INCLINE")
}
