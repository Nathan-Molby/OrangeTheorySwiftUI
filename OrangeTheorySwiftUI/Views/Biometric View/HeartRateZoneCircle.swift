//
//  HeartRateZoneCircle.swift
//  OrangeTheorySwiftUI
//
//  Created by Nathan Molby on 3/8/25.
//

import SwiftUI

struct HeartRateZoneCircle: View {
    let zone: HeartRateZone
    
    var totalCircleSegments: Int {
        // There is an empty section at the bottom
        HeartRateZone.allCases.count + 1
    }
    
    var percentageForEachSegment: Double {
        return 1.0 / Double(totalCircleSegments)
    }
    
    func colorForSegment(id: Int) -> Color {
        guard id < HeartRateZone.allCases.endIndex, let inputZoneIndex = HeartRateZone.allCases.firstIndex(of: zone) else { return Color.clear }
        
        return inputZoneIndex < id ? Color.white.opacity(0.5) : Color.white
    }
    
    
    var body: some View {
        ZStack {
            ForEach(0..<totalCircleSegments, id: \.self) { segmentId in
                Circle()
                    .strokeBorder(lineWidth: 10)
                    .foregroundStyle(colorForSegment(id: segmentId))
                    .mask {
                        MaskableCircle(progress: percentageForEachSegment - 0.01)
                            .rotation(.degrees(360) * percentageForEachSegment * Double(segmentId) + .degrees(180))
                    }

            }
        }
    }
}

#Preview {
    @Previewable @State var zone = HeartRateZone.gray
    
    VStack {
        Picker("Zone", selection: $zone) {
            ForEach(HeartRateZone.allCases) { zone in
                Text(zone.displayValue)
            }
        }
        
        HeartRateZoneCircle(zone: zone)
    }
    .padding()
    .frame(width: 400)
    .background(zone.color)
}
