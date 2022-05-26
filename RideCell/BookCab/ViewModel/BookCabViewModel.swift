//
//  BookCabViewModel.swift
//  RideCell
//
//  Created by ityx  on 26/05/22.
//

import Foundation



class BookCabViewModel {
    
    func getCabs()  {
        
        if let path = Bundle.main.path(forResource: "sample", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let cabs = jsonResult as? [[String:AnyObject]] {
                    for cab in cabs {
                        print("cab: \(cab)")
                    }
                }
              } catch {
                   // handle error
              }
        }
        
    }
}
