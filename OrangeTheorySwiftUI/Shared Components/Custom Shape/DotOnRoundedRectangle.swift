//
//  DotOnRoundedRectangle.swift
//  OrangeTheorySwiftUI
//
//  Created by Nathan Molby on 2/15/25.
//

import SwiftUI

struct DotOnRoundedRectangle: Shape {
    let cornerRadius: CGFloat
    let circleRadius: CGFloat
    var percentFilled: Double
    
    var animatableData: Double {
        get { percentFilled }
        set { percentFilled = newValue }
    }
        
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let point = pointAtPercentage(in: rect)
        path.addEllipse(in: CGRect(x: point.x - circleRadius,
                                  y: point.y - circleRadius,
                                  width: circleRadius * 2,
                                  height: circleRadius * 2))
        
        return path
    }
    
    func pointAtPercentage(in rect: CGRect) -> CGPoint {
        let totalBorder = (rect.width - 2 * cornerRadius) * 2 + (rect.height - 2 * cornerRadius) * 2 + 2 * Double.pi * cornerRadius
        var totalPercentageCovered = 0.0
        
        // Bottom right flat side
        let percentageInBottomRightFlatSide = (rect.width / 2 - cornerRadius) / totalBorder
        totalPercentageCovered += percentageInBottomRightFlatSide
            
        if percentFilled < totalPercentageCovered {
            let percentAlongBottomRightCorner = percentFilled / percentageInBottomRightFlatSide
            return .init(
                x: rect.midX + percentAlongBottomRightCorner * (rect.width / 2 - cornerRadius),
                y: rect.maxY
            )
        }
        
        // Bottom right corner
        let percentageInBottomRightCorner = Double.pi * cornerRadius / 2 / totalBorder
        totalPercentageCovered += percentageInBottomRightCorner
        
        let bottomRightCornerCenter = CGPoint(x: rect.maxX - cornerRadius, y: rect.maxY - cornerRadius)
            
        if percentFilled < totalPercentageCovered {
            let percentBeforeBottomRightCorner = totalPercentageCovered - percentageInBottomRightCorner
            let percentageThroughBottomRightCorner = (percentFilled - percentBeforeBottomRightCorner) / percentageInBottomRightCorner
            let angle = Angle.degrees(90 - 90 * percentageThroughBottomRightCorner)
            return .init(
                x: bottomRightCornerCenter.x + cornerRadius * CGFloat(cos(angle.radians)),
                y: bottomRightCornerCenter.y + cornerRadius * CGFloat(sin(angle.radians))
            )
        }
        
        // Right side
        let percentageInRightSide = (rect.height - 2 * cornerRadius) / totalBorder
        totalPercentageCovered += percentageInRightSide
        
        if percentFilled < totalPercentageCovered {
            let percentBeforeRightSide = totalPercentageCovered - percentageInRightSide
            let percentageThroughRightSide = (percentFilled - percentBeforeRightSide) / percentageInRightSide
            return .init(
                x: rect.maxX,
                y: rect.maxY - cornerRadius - percentageThroughRightSide * (rect.height - 2 * cornerRadius)
            )
        }
        
        // Top right corner
        let topRightCornerCenter = CGPoint(x: rect.maxX - cornerRadius, y: rect.minY + cornerRadius)
        let percentageInTopRightCorner = Double.pi * cornerRadius / 2 / totalBorder
        totalPercentageCovered += percentageInTopRightCorner

        if percentFilled < totalPercentageCovered {
            let percentBeforeTopRightCorner = totalPercentageCovered - percentageInTopRightCorner
            let percentageThroughTopRightCorner = (percentFilled - percentBeforeTopRightCorner) / percentageInTopRightCorner
            let angle = Angle.degrees(360 - 90 * percentageThroughTopRightCorner)
            return .init(
                x: topRightCornerCenter.x + cornerRadius * CGFloat(cos(angle.radians)),
                y: topRightCornerCenter.y + cornerRadius * CGFloat(sin(angle.radians))
            )
        }
        
        // Top side
        let percentageInTopSide = (rect.width - 2 * cornerRadius) / totalBorder
        totalPercentageCovered += percentageInTopSide
        
        if percentFilled < totalPercentageCovered {
            let percentBeforeTopSide = totalPercentageCovered - percentageInTopSide
            let percentageThroughTopSide = (percentFilled - percentBeforeTopSide) / percentageInTopSide
            return .init(
                x: rect.maxX - cornerRadius - percentageThroughTopSide * (rect.width - 2 * cornerRadius),
                y: rect.minY
            )
        }
        
        // Top left corner
        let topLeftCornerCenter = CGPoint(x: rect.minX + cornerRadius, y: rect.minY + cornerRadius)
        let percentageInTopLeftCorner = Double.pi * cornerRadius / 2 / totalBorder
        totalPercentageCovered += percentageInTopLeftCorner

        if percentFilled < totalPercentageCovered {
            let percentBeforeTopLeftCorner = totalPercentageCovered - percentageInTopLeftCorner
            let percentageThroughTopLeftCorner = (percentFilled - percentBeforeTopLeftCorner) / percentageInTopLeftCorner
            let angle = Angle.degrees(270 - 90 * percentageThroughTopLeftCorner)
            return .init(
                x: topLeftCornerCenter.x + cornerRadius * CGFloat(cos(angle.radians)),
                y: topLeftCornerCenter.y + cornerRadius * CGFloat(sin(angle.radians))
            )
        }
        
        // Left side
        let percentageInLeftSide = (rect.height - 2 * cornerRadius) / totalBorder
        totalPercentageCovered += percentageInLeftSide
        
        if percentFilled < totalPercentageCovered {
            let percentBeforeLeftSide = totalPercentageCovered - percentageInLeftSide
            let percentageThroughLeftSide = (percentFilled - percentBeforeLeftSide) / percentageInLeftSide
            return .init(
                x: rect.minX,
                y: rect.minY + cornerRadius + percentageThroughLeftSide * (rect.height - 2 * cornerRadius)
            )
        }
        
        // Bottom left corner
        let bottomLeftCornerCenter = CGPoint(x: rect.minX + cornerRadius, y: rect.maxY - cornerRadius)
        let percentageInBottomLeftCorner = Double.pi * cornerRadius / 2 / totalBorder
        totalPercentageCovered += percentageInBottomLeftCorner

        if percentFilled < totalPercentageCovered {
            let percentBeforeBottomLeftCorner = totalPercentageCovered - percentageInBottomLeftCorner
            let percentageThroughBottomLeftCorner = (percentFilled - percentBeforeBottomLeftCorner) / percentageInBottomLeftCorner
            let angle = Angle.degrees(180 - 90 * percentageThroughBottomLeftCorner)
            return .init(
                x: bottomLeftCornerCenter.x + cornerRadius * CGFloat(cos(angle.radians)),
                y: bottomLeftCornerCenter.y + cornerRadius * CGFloat(sin(angle.radians))
            )
        }
        
        // Bottom left flat side
        let percentageInBottomLeftFlatSide = (rect.width / 2 - cornerRadius) / totalBorder
        totalPercentageCovered += percentageInBottomLeftFlatSide
        
        // Final segment
        let percentBeforeBottomLeftSide = totalPercentageCovered - percentageInBottomLeftFlatSide
        let percentageThroughBottomLeftSide = (percentFilled - percentBeforeBottomLeftSide) / percentageInBottomLeftFlatSide
        return .init(
            x: rect.minX + cornerRadius + percentageThroughBottomLeftSide * (rect.width / 2 - cornerRadius),
            y: rect.maxY
        )
    }
}

#Preview {
    @Previewable @State var percentFilled: CGFloat = 0.01
    
    VStack {
        Slider(value: $percentFilled, in: 0...1)
        
        DotOnRoundedRectangle(cornerRadius: 50, circleRadius: 10, percentFilled: percentFilled)
            .fill(.red)
            .frame(height: 400)
            .padding(.horizontal, 40)
    }

}
