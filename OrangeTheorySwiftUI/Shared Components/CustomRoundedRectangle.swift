//
//  CustomRoundedRectangle.swift
//  OrangeTheorySwiftUI
//
//  Created by Nathan Molby on 2/15/25.
//

import SwiftUI

struct CustomRoundedRectangle: Shape {
    let cornerRadius: CGFloat
    var percentFilled: Double
    
    var animatableData: Double {
        get { percentFilled }
        set { percentFilled = newValue }
    }

    func path(in rect: CGRect) -> Path {
        var path = Path()
                
        path.move(to: .init(x: rect.midX, y: rect.maxY))
        
        let totalBorder = (rect.width - 2 * cornerRadius) * 2 + (rect.height - 2 * cornerRadius) * 2 + 2 * Double.pi * cornerRadius
        
        var totalPercentageCovered = 0.0
        
        // Bottom right flat side
        let percentageInBottomRightFlatSide = (rect.width / 2 - cornerRadius) / totalBorder
        totalPercentageCovered += percentageInBottomRightFlatSide
            
        guard percentFilled >= totalPercentageCovered else {
            let percentAlongBottomRightCorner = percentFilled / totalPercentageCovered
            path.addLine(to: .init(x: rect.midX + percentAlongBottomRightCorner * (rect.width / 2 - cornerRadius), y: rect.maxY))
            return path
        }
        
        path.addLine(to: .init(x: rect.maxX - cornerRadius, y: rect.maxY))
        
        // Bottom right corner
        let percentageInBottomRightCorner = Double.pi * cornerRadius / 2 / totalBorder
        totalPercentageCovered += percentageInBottomRightCorner
        
        let bottomRightCornerCenter = CGPoint(x: rect.maxX - cornerRadius, y: rect.maxY - cornerRadius)
            
        guard percentFilled >= totalPercentageCovered else {
            let percentBeforeBottomRightCorner = totalPercentageCovered - percentageInBottomRightCorner
            let percentageThroughBottomRightCorner = (percentFilled - percentBeforeBottomRightCorner) / percentageInBottomRightCorner
            path.addArc(center: bottomRightCornerCenter, radius: cornerRadius, startAngle: .degrees(90), endAngle: .degrees(90) - .degrees(90) * percentageThroughBottomRightCorner, clockwise: true)
            return path
        }
        
        path.addArc(center: bottomRightCornerCenter, radius: cornerRadius, startAngle: .degrees(90), endAngle: .degrees(0), clockwise: true)
        
        // Right side
        let percentageInRightSide = (rect.height - 2 * cornerRadius) / totalBorder
        totalPercentageCovered += percentageInRightSide
        
        guard percentFilled >= totalPercentageCovered else {
            let percentBeforeRightSide = totalPercentageCovered - percentageInRightSide
            let percentageThroughRightSide = (percentFilled - percentBeforeRightSide) / percentageInRightSide
            path.addLine(to: .init(x: rect.maxX, y: rect.maxY - cornerRadius - percentageThroughRightSide * (rect.height - 2 * cornerRadius)))
            return path
        }
        
        path.addLine(to: .init(x: rect.maxX, y: rect.minY + cornerRadius))
        
        // Top right corner
        let topRightCornerCenter = CGPoint(x: rect.maxX - cornerRadius, y: rect.minY + cornerRadius)
        let percentageInTopRightCorner = Double.pi * cornerRadius / 2 / totalBorder
        totalPercentageCovered += percentageInTopRightCorner
        
        guard percentFilled >= totalPercentageCovered else {
            let percentBeforeTopRightCorner = totalPercentageCovered - percentageInTopRightCorner
            let percentageThroughTopRightCorner = (percentFilled - percentBeforeTopRightCorner) / percentageInTopRightCorner
            path.addArc(center: topRightCornerCenter, radius: cornerRadius, startAngle: .degrees(0), endAngle: .degrees(-90) * percentageThroughTopRightCorner, clockwise: true)
            return path
        }
        
        path.addArc(center: topRightCornerCenter, radius: cornerRadius, startAngle: .degrees(0), endAngle: .degrees(-90), clockwise: true)
        
        // Top side
        let percentageInTopSide = (rect.width - 2 * cornerRadius) / totalBorder
        totalPercentageCovered += percentageInTopSide
        
        guard percentFilled >= totalPercentageCovered else {
            let percentBeforeTopSide = totalPercentageCovered - percentageInTopSide
            let percentageThroughTopSide = (percentFilled - percentBeforeTopSide) / percentageInTopSide
            path.addLine(to: .init(x: rect.maxX - cornerRadius - percentageThroughTopSide * (rect.width - 2 * cornerRadius), y: rect.minY))
            return path
        }
        
        path.addLine(to: .init(x: rect.minX + cornerRadius, y: rect.minY))
        
        // Top left corner
        let topLeftCornerCenter = CGPoint(x: rect.minX + cornerRadius, y: rect.minY + cornerRadius)
        let percentageInTopLeftCorner = Double.pi * cornerRadius / 2 / totalBorder
        totalPercentageCovered += percentageInTopLeftCorner
        
        guard percentFilled >= totalPercentageCovered else {
            let percentBeforeTopLeftCorner = totalPercentageCovered - percentageInTopLeftCorner
            let percentageThroughTopLeftCorner = (percentFilled - percentBeforeTopLeftCorner) / percentageInTopLeftCorner
            path.addArc(center: topLeftCornerCenter, radius: cornerRadius, startAngle: .degrees(-90), endAngle: .degrees(-90) - .degrees(90) * percentageThroughTopLeftCorner, clockwise: true)
            return path
        }
        
        path.addArc(center: topLeftCornerCenter, radius: cornerRadius, startAngle: .degrees(-90), endAngle: .degrees(-180), clockwise: true)
        
        // Left side
        let percentageInLeftSide = (rect.height - 2 * cornerRadius) / totalBorder
        totalPercentageCovered += percentageInLeftSide
        
        guard percentFilled >= totalPercentageCovered else {
            let percentBeforeLeftSide = totalPercentageCovered - percentageInLeftSide
            let percentageThroughLeftSide = (percentFilled - percentBeforeLeftSide) / percentageInLeftSide
            path.addLine(to: .init(x: rect.minX, y: rect.minY + cornerRadius + percentageThroughLeftSide * (rect.height - 2 * cornerRadius)))
            return path
        }
        
        path.addLine(to: .init(x: rect.minX, y: rect.maxY - cornerRadius))
        
        // Bottom left corner
        let bottomLeftCornerCenter = CGPoint(x: rect.minX + cornerRadius, y: rect.maxY - cornerRadius)
        let percentageInBottomLeftCorner = Double.pi * cornerRadius / 2 / totalBorder
        totalPercentageCovered += percentageInBottomLeftCorner
        
        guard percentFilled >= totalPercentageCovered else {
            let percentBeforeBottomLeftCorner = totalPercentageCovered - percentageInBottomLeftCorner
            let percentageThroughBottomLeftCorner = (percentFilled - percentBeforeBottomLeftCorner) / percentageInBottomLeftCorner
            path.addArc(center: bottomLeftCornerCenter, radius: cornerRadius, startAngle: .degrees(180), endAngle: .degrees(180) - .degrees(90) * percentageThroughBottomLeftCorner, clockwise: true)
            return path
        }
        
        path.addArc(center: bottomLeftCornerCenter, radius: cornerRadius, startAngle: .degrees(180), endAngle: .degrees(90), clockwise: true)
        
        // Bottom left flat side
        let percentageInBottomLeftFlatSide = (rect.width / 2 - cornerRadius) / totalBorder
        totalPercentageCovered += percentageInBottomLeftFlatSide
        
        guard percentFilled >= totalPercentageCovered else {
            let percentBeforeBottomLeftSide = totalPercentageCovered - percentageInBottomLeftFlatSide
            let percentageThroughBottomLeftSide = (percentFilled - percentBeforeBottomLeftSide) / percentageInBottomLeftFlatSide
            path.addLine(to: .init(x: rect.minX + cornerRadius + percentageThroughBottomLeftSide * (rect.width / 2 - cornerRadius), y: rect.maxY))
            return path
        }
        
        path.addLine(to: .init(x: rect.midX, y: rect.maxY))
        
        return path
    }
}

#Preview {
    @Previewable @State var percentFilled: CGFloat = 0.01
    
    VStack {
        Slider(value: $percentFilled, in: 0...1)
        
        CustomRoundedRectangle(cornerRadius: 50, percentFilled: percentFilled)
        
            .stroke(.red)
            .frame(height: 400)
            .padding(.horizontal, 40)
    }

}
