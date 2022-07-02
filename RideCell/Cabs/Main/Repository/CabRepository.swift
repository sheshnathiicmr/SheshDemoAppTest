//
//  Repository.swift
//  RideCell
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
                print("response: \(response)")
                if let cabsJSON = response as? [[String:AnyObject]] {
                    var cabs = [Cab]()
                    for cabJSON in cabsJSON {
                        if let cab = self.getCab(with: cabJSON) {
                            cabs.append(cab)
                        }
                    }
                    DispatchQueue.main.async {
                        completion(.success(cabs))
                    }
                }else {
                    DispatchQueue.main.async {
                        completion(.failure(CustomError.parsing("error_during_parsing".localized)))
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
    
    private func getCab(with cabJSON:[String:AnyObject]) -> Cab? {
        let id = cabJSON["id"] as! String
        let modelIdentifier = cabJSON["modelIdentifier"] as! String
        let modelName = cabJSON["modelName"] as! String
        let name = cabJSON["name"] as! String
        let make = cabJSON["make"] as! String
        let group = cabJSON["group"] as! String
        let color = cabJSON["color"] as! String
        let series = cabJSON["series"] as! String
        let fuelType = cabJSON["fuelType"] as! String
        let fuelLevel = cabJSON["fuelLevel"] as! Double
        let transmission = cabJSON["transmission"] as! String
        let licensePlate = cabJSON["licensePlate"] as! String
        let latitude = cabJSON["latitude"] as? Double
        let longitude = cabJSON["longitude"] as? Double
        let innerCleanliness = cabJSON["innerCleanliness"] as! String
        let carImageUrl = cabJSON["carImageUrl"] as! String
        
        let cab = Cab(id: id, modelIdentifier: modelIdentifier, modelName: modelName, name: name, make: make, group: group, color: color, series: series, fuelType: fuelType, fuelLevel: fuelLevel, transmission: transmission, licensePlate: licensePlate, latitude: latitude, longitude: longitude, innerCleanliness: innerCleanliness, carImageUrl: carImageUrl)
        return cab
    }
    
}
