//
//  APIError.swift
//  Singapore Breathe
//
//  Created by Stuart Breckenridge on 26/12/2020.
//

import Foundation

public enum APIError: LocalizedError {
    
    case noData
    case invalidResponse (Int)
    case other (Error)
    
    public var errorDescription: String? {
        switch self {
        case .noData:
            return L10N.apiErrorNoData
        case .invalidResponse(let statusCode):
            return HTTPURLResponse.localizedString(forStatusCode: statusCode)
        case .other(let err):
            return L10N.apiErrorOther(err.localizedDescription)
        }
    }
    
}
