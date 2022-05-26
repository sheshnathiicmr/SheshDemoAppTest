//
//  CustomError.swift
//  RideCell
//
//  Created by ityx  on 26/05/22.
//

import Foundation

public enum CustomError: Swift.Error {
    case parsing(String)
    case unknown
   
    func getErrorMessage() -> String {
        switch self {
        case .parsing(let errorMessage):
            return errorMessage
        case .unknown:
            return "error unknown"
        }
    }
}

