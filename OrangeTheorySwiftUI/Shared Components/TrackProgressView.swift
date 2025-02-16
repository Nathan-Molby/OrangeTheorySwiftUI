//
//  TrackProgressView.swift
//  OrangeTheorySwiftUI
//
//  Created by Nathan Molby on 2/15/25.
//

import SwiftUI

/// Displays a progress in the form of a track
struct AddTrackProgressViewModifier: ViewModifier {
    let endProgress: CGFloat = 0.5
    
    func body(content: Content) -> some View {
        content
            .padding(.vertical, 100)
            .padding(.horizontal, 40)
            .background {
                ZStack {
                    RoundedRectangle(cornerRadius: 150)
                        .strokeBorder(.chartSecondary, lineWidth: 7)
                        .mask {
                            MaskableCircle(progress: endProgress)
                                .scale(3)
                                .rotation(.degrees(90))
                        }
                        
                }

            }
    }
}
#Preview {
//    HStack() {
//        Spacer()
//        
//        MetricView(metricWithUnit: .manuallyFormatted(metric: "20", unit: "mi"), label: "Distance")
//
//        Spacer()
//        
//        MetricView(metricWithUnit: .manuallyFormatted(metric: "27:45", unit: "minutes"), label: "Time")
//        
//        Spacer()
//
//    }
    
    Text("Content")
        .frame(maxWidth: .infinity)
        .frame(height: 200)
        .modifier(AddTrackProgressViewModifier())

}
