//
//  MetricView.swift
//  OrangeTheorySwiftUI
//
//  Created by Nathan Molby on 2/8/25.
//

import SwiftUI

struct MetricView: View {
    let metric: String
    let label: String
    let icon: Image?
    let unit: String?
    
    
    var body: some View {
        HStack(alignment: .top) {
            icon?
                .resizable()
                .scaledToFit()
                .frame(width: 20)
            
            VStack(alignment: .leading, spacing: 4) {
                HStack(alignment: .bottom, spacing: 2) {
                    TextWithoutVerticalPadding(metric, fontStyle: .largeTitle)
                    
                    if let unit {
                        TextWithoutVerticalPadding(unit, fontStyle: .headline)
                    }
                }
                
                Text(label)
                    .font(.subheadline)
            }
            
        }
    }
}

#Preview {
    MetricView(metric: "0.04", label: "Total Time", icon: .init(systemName: "arrow.triangle.swap"), unit: "mi")
}
