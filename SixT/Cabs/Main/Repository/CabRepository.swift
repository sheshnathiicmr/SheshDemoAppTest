//
//  Repository.swift
//  SixT
//
//  Created by sheshnath  on 26/05/22.
//

import Foundation

protocol CabRepositoryProtocol {
    func fetchCabs(with completion: @escaping (Result<[Cab], CustomError>) -> Void)
}

class CabRepository: CabRepositoryProtocol {

    func fetchCabs(with completion: @escaping (Result<[Cab], CustomError>) -> Void) {
        ApiRequestManager.shared.getCabsInfo { result in
            switch result {
            case .success(let response):
                if let cabs = self.getCab(with: response) {
                    DispatchQueue.main.async {
                        completion(.success(cabs))
                    }
                }else {
                    completion(.failure(CustomError.parsing("error_during_parsing".localized)))
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
    
    private func getCab(with cabsJSONData:Data) -> [Cab]? {
        let cabs = try! JSONDecoder().decode([Cab].self, from: cabsJSONData)
        return cabs
    }
    
}
