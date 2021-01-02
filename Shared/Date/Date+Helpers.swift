//
//  Date+Helpers.swift
//  Singapore Breathe
//
//  Created by Stuart Breckenridge on 30/12/2020.
//

import Foundation

public extension Date {
    
    func toString(timeStyle: DateFormatter.Style = .medium, dateStyle: DateFormatter.Style = .medium) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = timeStyle
        dateFormatter.dateStyle = dateStyle
        return dateFormatter.string(from: self)
    }
}
