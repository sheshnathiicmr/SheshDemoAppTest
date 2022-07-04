//
//  ApiRequestManager.swift
//  SixT
//
//  Created by ityx  on 02/07/22.
//

import Foundation

class ApiRequestManager {
    
    static let shared = ApiRequestManager()
    private let baseUrl = "https://cdn.sixt.io/codingtask"

    func getCabsInfo(with completion: @escaping (Result<Data, CustomError>) -> Void) {
        let task = URLSession.shared.dataTask(with: NSURL(string: "\(baseUrl)/cars")! as URL, completionHandler: { (data, response, error) -> Void in
            if let responseData = data {
                completion(.success(responseData))
            }else {
                completion(.failure(CustomError.serverError))
            }
        })
        task.resume()
    }
    
}
