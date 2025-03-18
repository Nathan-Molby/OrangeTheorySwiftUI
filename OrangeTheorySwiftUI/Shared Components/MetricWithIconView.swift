//
//  MetricWithIconView.swift
//  OrangeTheorySwiftUI
//
//  Created by Nathan Molby on 2/8/25.
//

import SwiftUI

struct MetricWithIconView: View {
    let metricWithUnit: MetricWithUnit
    let label: String
    let icon: Image?
    
    init(metricWithUnit: MetricWithUnit, label: String, icon: Image? = nil) {
        self.metricWithUnit = metricWithUnit
        self.label = label
        self.icon = icon
    }
    
    
    var unit: String? {
        return metricWithUnit.unit.isEmpty ? nil : metricWithUnit.unit
    }
    
    
    var body: some View {
        VStack(alignment: .leadingAlignment1, spacing: 8) {
            HStack(alignment: .firstTextBaseline, spacing: 4) {
                Label {
                    Text(metricWithUnit.metric)
                        .font(.largest)
                        .italic()
                        .alignmentGuide(HorizontalAlignment.leadingAlignment1) { dimensions in
                            dimensions[.leading]
                        }
                } icon: {
                    icon?
                        .resizable()
                        .scaledToFit()
                        .frame(height: 40)
                }
                
                
                if let unit {
                    Text(unit)
                        .font(.medium)
                        .bold()
                }
            }
            
            Text(label)
                .font(.mediumLight)
        }
    }
}

#Preview {
    MetricWithIconView(metricWithUnit: .init(metric: "5.02", unit: "mi"), label: "Total Time", icon: .init(systemName: "arrow.triangle.swap"))
}

extension HorizontalAlignment {
    struct LeadingAlignment1: AlignmentID {
        static func defaultValue(in context: ViewDimensions) -> CGFloat {
            context[.leading]
        }
    }

    static let leadingAlignment1 = HorizontalAlignment(LeadingAlignment1.self)
}
