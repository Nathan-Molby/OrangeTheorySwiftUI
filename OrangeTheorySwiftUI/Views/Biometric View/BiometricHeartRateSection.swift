//
//  BiometricHeartRateSection.swift
//  OrangeTheorySwiftUI
//
//  Created by Nathan Molby on 3/8/25.
//

import SwiftUI

struct BiometricHeartRateSection: View {
    @Environment(\.biometricDataProvider) var dataProvider
    
    var body: some View {
        HeartRateZoneCircle(zone: dataProvider.heartRateZone)
            .overlay {
                heartRateInfo
            }
    }
    
    var heartRateInfo: some View {
        VStack(spacing: 32) {
            HStack(alignment: .top) {
                Text(Int(dataProvider.currentHeartRatePercentage).formatted())
                    .font(.heartRateFont)
                    .bold()
                
                Image(systemName: "percent")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 30)
                    .padding(.top, 25)
            }
            
            HStack {
                ZStack {
                    Image(systemName: "heart.fill")
                        .resizable()
                        .scaledToFit()
                        .foregroundStyle(.white.opacity(0.5))
                        .frame(width: 40, height: 40)
                    
                    Image(systemName: "heart")
                        .resizable()
                        .scaledToFit()
                        .foregroundStyle(.white)
                        .frame(width: 42, height: 42)
                }
                
                Text(Int(dataProvider.currentHeartRate).formatted())
                    .font(.large)
                    .bold()
            }
        }
    }
}

#Preview {
    BiometricHeartRateSection()
        .frame(width: 400)
        .background(.orangeZone)
}
