//
//  Endpoints.swift
//  Singapore Breathe
//
//  Created by Stuart Breckenridge on 26/12/2020.
//

import Foundation

public enum Endpoints {
    
    case psi, pm25
    
    var url: URL {
        switch self {
        case .pm25:
            return URL(string: "https://api.data.gov.sg/v1/environment/pm25")!
        case .psi:
            return URL(string: "https://api.data.gov.sg/v1/environment/psi")!
        }
    }
}
