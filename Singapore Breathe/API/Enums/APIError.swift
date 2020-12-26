//
//  APIError.swift
//  Singapore Breathe
//
//  Created by Stuart Breckenridge on 26/12/2020.
//

import Foundation

public enum APIError: LocalizedError {
    
    case noData
    case other (Error)
    
    public var errorDescription: String? {
        switch self {
        case .noData:
            return L10N.apiErrorNoData
        case .other(let err):
            return L10N.apiErrorOther(err.localizedDescription)
        }
    }
    
    
}
