//
//  MaskableCircle.swift
//  OrangeTheorySwiftUI
//
//  Created by Nathan Molby on 2/15/25.
//

import SwiftUI

struct MaskableCircle: Shape {
    var progress: CGFloat
    
    var animatableData: Double {
        get { progress }
        set { progress = newValue }
    }
    
    nonisolated func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let circleCenter = CGPoint(x: rect.midX, y: rect.midY)
        path.move(to: circleCenter)
        
        guard progress > 0  else { return path }
        
        path.addLine(to: .init(x: rect.maxX, y: rect.midY))

        path.addArc(center: circleCenter, radius: rect.width / 2, startAngle: .zero, endAngle: .degrees(360 * (1 - progress)), clockwise: true)
                
        return path
        
    }
}


#Preview {
    MaskableCircle(progress: 0.5)
        .rotation(.degrees(90))
        .frame(width: 300, height: 300)
        .border(.red)
}
