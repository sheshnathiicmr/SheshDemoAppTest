//
//  Repository.swift
//  SixT
//
//  Created by sheshnath  on 26/05/22.
//

import Foundation

protocol CabRepositoryProtocol {
    func fetchCabs(completion: @escaping (Result<[Cab], CustomError>) -> Void)
}

class CabRepository: CabRepositoryProtocol {

    var apiHandler:ApiRequestProtocol!
    
    init(apiHandler:ApiRequestProtocol) {
        self.apiHandler = apiHandler
    }
    
    func fetchCabs(completion: @escaping (Result<[Cab], CustomError>) -> Void) {
        self.apiHandler.getCabsInfo { result in
            switch result {
            case .success(let response):
                let result = self.decodeJSON(with: response)
                DispatchQueue.main.async {
                    completion(result)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
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
