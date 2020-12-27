//
//  Double+String.swift
//  Singapore Breathe
//
//  Created by Stuart Breckenridge on 27/12/2020.
//

import Foundation

public extension Double {
    
    /// cConverts `Double` values to a `String` and will remove fractional digits when they equate to `0`, e.g. `27.0` will be shown as `"27"` while `28.3` will be shown as `"28.3"`.
    var displayString: String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(from: NSNumber(value: self)) ?? ""
    }
    
}
