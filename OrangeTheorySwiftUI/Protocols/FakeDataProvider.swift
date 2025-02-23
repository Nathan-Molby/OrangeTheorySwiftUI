//
//  FakeDataProvider.swift
//  OrangeTheorySwiftUI
//
//  Created by Nathan Molby on 2/7/25.
//

import Foundation


/// A data provider that allows "on-demand" data measurement given a certain time
protocol FakeDataProvider {
    /// Updates the currentDistance and currentTime
    mutating func executeDataMeasurement(forTime: Date)
    
    /// Updates speedHistory and inclineHistory
    mutating func executeHistoryDataMeasurement(forTime: Date)
}
