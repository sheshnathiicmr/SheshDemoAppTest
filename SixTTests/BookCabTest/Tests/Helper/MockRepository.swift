//
//  MockRepository.swift
//  SixTTests
//
//  Created by sheshnath  on 27/05/22.
//

import Foundation
@testable import SixT

class MockRepository: CabRepositoryProtocol {
    
    func fetchCabs(with completion: @escaping (Result<[Cab], CustomError>) -> Void) {
        let testBundle = Bundle(for: type(of: self))
        if let path = testBundle.path(forResource: "mock_cabs", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let result = self.decodeJSON(with: data)
                DispatchQueue.main.async {
                    completion(result)
                }
              } catch {
                  completion(.failure(.parsing("error_during_parsing".localized)))
              }
        }
    }
    
    private func decodeJSON(with cabsJSONData:Data) -> Result<[Cab], CustomError> {
        let decoder = JSONDecoder()
        do {
            let cabs = try decoder.decode([Cab].self, from: cabsJSONData)
            return .success(cabs)
        } catch {
            return .failure(CustomError.parsing(error.localizedDescription))
        }
    }
}
