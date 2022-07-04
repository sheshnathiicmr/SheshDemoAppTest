//
//  MockAPI.swift
//  SixTTests
//
//  Created by ityx  on 04/07/22.
//

import Foundation
@testable import SixT

class MockAPI: ApiRequestProtocol {
    
    var baseURL: String = ""
    
    func getCabsInfo(with completion: @escaping (Result<Data, CustomError>) -> Void) {
        let testBundle = Bundle(for: type(of: self))
        if let path = testBundle.path(forResource: "mock_cabs", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                completion(.success(data))
            }catch {
                completion(.failure(CustomError.serverError))
            }
        }else {
            completion(.failure(CustomError.serverError))
        }
    }
}
