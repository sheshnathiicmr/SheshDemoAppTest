//
//  CustomError.swift
//  SixT
//
//  Created by sheshnath  on 26/05/22.
//

import Foundation

public enum CustomError: Swift.Error {
    case parsing(String)
    case serverError
    case unknown
    
    func getErrorMessage() -> String {
        switch self {
        case .parsing(let errorMessage):
            return errorMessage
        case .serverError:
            return "something went wrong while communicating with our server"
        case .unknown:
            return "error unknown"
        }
    }
}

