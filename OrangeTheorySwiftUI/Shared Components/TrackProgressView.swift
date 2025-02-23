//
//  TrackProgressView.swift
//  OrangeTheorySwiftUI
//
//  Created by Nathan Molby on 2/15/25.
//

import SwiftUI

/// Displays a progress in the form of a track
struct AddTrackProgressViewModifier: ViewModifier {
    let progress: CGFloat
    
    func body(content: Content) -> some View {
        content
            .padding(.vertical, 100)
            .padding(.horizontal, 40)
            .background {
                ZStack {
                    CustomRoundedRectangle(cornerRadius: 150, percentFilled: 100)
                        .stroke(.gray, lineWidth: 5)
                    
                    CustomRoundedRectangle(cornerRadius: 150, percentFilled: progress)
                        .stroke(Color.chartSecondary, lineWidth: 5)
                    
                    DotOnRoundedRectangle(cornerRadius: 150, circleRadius: 15, percentFilled: progress)
                        .fill(Color.chartSecondary)
                }
                .padding(15)

            }
    }
}

extension View {
    func addProgressTracker(progress: CGFloat) -> some View {
        modifier(AddTrackProgressViewModifier(progress: progress))
    }
}

#Preview {
    @Previewable @State var percentFilled: CGFloat = 0.01
    
    VStack {
        Button("Click Me") {
            withAnimation {
                percentFilled = .random(in: 0...1)
            }
        }
        Slider(value: $percentFilled, in: 0...1)
        
        Text("Content")
            .frame(width: 400)
            .frame(height: 200)
            .addProgressTracker(progress: percentFilled)
    }
}
