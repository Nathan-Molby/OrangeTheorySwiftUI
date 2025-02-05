//
//  EnvironmentValues+Ext.swift
//  OrangeTheorySwiftUI
//
//  Created by Nathan Molby on 2/4/25.
//

import SwiftUI

extension EnvironmentValues {
    @Entry var treadmillDataProvider: TreadmillDataProvider = StaticTreadmillDataProvider(incline: .init(value: 2, unit: .incline), speed: .init(value: 5, unit: .milesPerHour))
}
