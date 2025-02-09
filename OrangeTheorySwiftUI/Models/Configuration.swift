//
//  Configuration.swift
//  OrangeTheorySwiftUI
//
//  Created by Nathan Molby on 2/9/25.
//

import Foundation

struct Configuration {
    /// Whether all formatting should be based on user's current locale or handled manually through config screen
    var useLocale: Bool = false
    var lengthUnit: UnitLength = .miles
    var durationUnit: UnitDuration = .minutes
    
    func formatLength(_ input: Measurement<UnitLength>) -> MetricWithUnit {
        if useLocale {
            let formattedInput = input.formatted(.measurement(width: .wide, usage: .person))
            return .formattedByLocale(formattedInput)
        } else {
            let convertedInput = input.converted(to: lengthUnit)
            return .manuallyFormatted(metric: convertedInput.value.formatted(.number.precision(.fractionLength(2))), unit: convertedInput.unit.symbol)
        }
    }
    
    func formatTime(_ input: Measurement<UnitDuration>) -> MetricWithUnit {
        let formattedInput = input.formatted(.measurement(width: .abbreviated))
        return .formattedByLocale(formattedInput)
    }
}
