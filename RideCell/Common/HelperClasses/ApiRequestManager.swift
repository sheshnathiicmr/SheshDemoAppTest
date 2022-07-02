//
//  ApiRequestManager.swift
//  RideCell
//
//  Created by ityx  on 02/07/22.
//

import Foundation

class ApiRequestManager {
    
    static let shared = ApiRequestManager()
    private let baseUrl = "https://cdn.sixt.io/codingtask"

    func getCabsInfo(with completion: @escaping (Result<Any, CustomError>) -> Void) {
        let task = URLSession.shared.dataTask(with: NSURL(string: "\(baseUrl)/cars")! as URL, completionHandler: { (data, response, error) -> Void in
            do{
                if let responseData = data {
                    let jsonResult = try JSONSerialization.jsonObject(with: responseData, options: .mutableLeaves)
                    completion(.success(jsonResult))
                }else {
                    completion(.failure(CustomError.serverError))
                }
            } catch {
                completion(.failure(CustomError.unknown))
            }
        })
        task.resume()
    }
    
}
