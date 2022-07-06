//
//  MockAPI.swift
//  SixTTests
//
//  Created by ityx  on 04/07/22.
//

import Foundation
@testable import SixT

enum ExpectationType {
    case success
    case serverError
}

class MockAPI: ApiRequestProtocol {
    
    var expectation:ExpectationType!
    
    init(expectation:ExpectationType) {
        self.expectation = expectation
    }
    
    var baseURL: String = ""
    
    func getCabsInfo(with completion: @escaping (Result<Data, CustomError>) -> Void) {
        switch self.expectation {
        case .success:
            let testBundle = Bundle(for: type(of: self))
            if let path = testBundle.path(forResource: "mock_cabs", ofType: "json") {
                do {
                    let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                    completion(.success(data))
                }catch {
                    completion(.failure(CustomError.serverError(errorCode: 402)))
                }
            }else {
                completion(.failure(CustomError.serverError(errorCode: 401)))
            }
        case .serverError:
            completion(.failure(CustomError.serverError(errorCode: 500)))
        case .none:
            completion(.failure(CustomError.unknown))
        }
    }
}
