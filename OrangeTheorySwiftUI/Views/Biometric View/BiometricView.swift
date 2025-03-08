//
//  BiometricView.swift
//  OrangeTheorySwiftUI
//
//  Created by Nathan Molby on 3/8/25.
//

import SwiftUI

struct BiometricView: View {
    @Environment(\.biometricDataProvider) var dataProvider
    @Environment(\.configuration) var configuration

    var body: some View {
        VStack {
            Text(dataProvider.name)
                .font(.large)
                .bold()
                .italic()
            
            Spacer()
            
            BiometricHeartRateSection()
                .frame(height: 440)
            
            HStack {
                HStack {
                    Image(systemName: "flame")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 60)
                        .foregroundStyle(.white)
                    
                    Text(Int(dataProvider.caloriesBurnt).formatted())
                        .font(.large)
                        .bold()
                }
                
                Spacer()
                
                HStack {
                    Image("Logo")
                        .renderingMode(.template)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 60)
                        .foregroundStyle(.white)
                    
                    Text(Int(dataProvider.splatPoints).formatted())
                        .font(.large)
                        .bold()
                }
            }
            
            Spacer()
            
            Text(configuration.formatTime(dataProvider.timeSinceStart).metric)
                .font(.large)
                .bold()
                .italic()
        }
        .padding(.horizontal, 60)
        .frame(maxWidth: .infinity)
        .background(dataProvider.heartRateZone.color)
    }
}

#Preview(traits: .landscapeLeft) {
    BiometricView()
        .frame(width: 500)
}
