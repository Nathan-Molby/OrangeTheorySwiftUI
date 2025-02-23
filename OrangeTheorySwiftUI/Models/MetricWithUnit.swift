//
//  MetricWithUnit.swift
//  OrangeTheorySwiftUI
//
//  Created by Nathan Molby on 2/9/25.
//

import Foundation

enum MetricWithUnit {
    /// When the user is manually selecting the unit
    case manuallyFormatted(metric: String, unit: String)
    
    /// When the metric is formatted by the locale
    case formattedByLocale(_ value: String)
    
    var metric: String {
        switch self {
        case .manuallyFormatted(let metric, _):
            return metric
        case .formattedByLocale(let value):
            return value
        }
    }
}
