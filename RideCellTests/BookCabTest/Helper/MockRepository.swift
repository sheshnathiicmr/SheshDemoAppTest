//
//  MockRepository.swift
//  RideCellTests
//
//  Created by ityx  on 27/05/22.
//

import Foundation
@testable import RideCell

class MockRepository: CabRepositoryProtocol {
    
    func fetchCabs(with completion: @escaping (Result<[Cab], CustomError>) -> Void) {
        let testBundle = Bundle(for: type(of: self))
        if let path = testBundle.path(forResource: "test_sample", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                var cabs = [Cab]()
                if let cabsJSON = jsonResult as? [[String:AnyObject]] {
                    for cabJSON in cabsJSON {
                        let id = cabJSON["id"] as! Int
                        let isActive = cabJSON["is_active"] as! Bool
                        let isAvailable = cabJSON["is_available"] as! Bool
                        let lat = cabJSON["lat"] as? Double
                        let lng = cabJSON["lng"] as? Double
                        let licensePlateNumber = cabJSON["license_plate_number"] as! String
                        let pool = cabJSON["pool"] as! String
                        let remainingMileage = cabJSON["remaining_mileage"] as! Int
                        let remainingRangeInMeters = cabJSON["remaining_range_in_meters"] as? Int
                        let transmissionMode = cabJSON["transmission_mode"] as? String
                        let vehicleMake = cabJSON["vehicle_make"] as! String
                        let seatCount = cabJSON["seat_count"] as! String
                        let vehiclePicAbsoluteUrl = cabJSON["vehicle_pic_absolute_url"] as! String
                        let vehicleType = cabJSON["vehicle_type"] as! String
                        let vehicleTypeId = cabJSON["vehicle_type_id"] as! Int
                        
                       let cab = Cab(id: id, isActive: isActive, isAvailable: isAvailable, lat: lat, lng: lng, licensePlateNumber: licensePlateNumber, pool: pool, remainingMileage: remainingMileage, remainingRangeInMeters: remainingRangeInMeters, transmissionMode: transmissionMode, vehicleMake: vehicleMake, seatCount: seatCount, vehiclePicAbsoluteUrl: vehiclePicAbsoluteUrl, vehicleType: vehicleType, vehicleTypeId: vehicleTypeId)
                        cabs.append(cab)
                    }
                    completion(.success(cabs))
                }else {
                    completion(.failure(.parsing("error_during_parsing".localized)))
                }
              } catch {
                  completion(.failure(.parsing("error_during_parsing".localized)))
              }
        }
    }
    
}
