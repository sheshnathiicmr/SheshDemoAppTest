//
//  ApiRequestHandler.swift
//  SixT
//
//  Created by ityx  on 02/07/22.
//

import Foundation

protocol ApiRequestProtocol:AnyObject {
    var baseURL:String { get set}
    func getCabsInfo(with completion: @escaping (Result<Data, CustomError>) -> Void)
}

class ApiRequestHandler: ApiRequestProtocol {
    
    var baseURL: String = "https://cdn.sixt.io/codingtask"
    
    func getCabsInfo(with completion: @escaping (Result<Data, CustomError>) -> Void) {
        let task = URLSession.shared.dataTask(with: NSURL(string: "\(baseURL)/cars")! as URL, completionHandler: { (data, response, error) -> Void in
            if let responseData = data {
                completion(.success(responseData))
            }else {
                completion(.failure(CustomError.serverError(errorCode: 500)))
            }
        })
        task.resume()
    }
    
}
