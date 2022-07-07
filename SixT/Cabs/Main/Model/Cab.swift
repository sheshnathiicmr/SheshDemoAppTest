//
//  Cab.swift
//  SixT
//
//  Created by sheshnath  on 26/05/22.
//

import Foundation

class Cab: Equatable, Codable {
    
    static func == (lhs: Cab, rhs: Cab) -> Bool {
        return lhs.id == rhs.id
    }
    
    ///MARK:- Properties
    var id:String
    var modelIdentifier:String
    var modelName:String
    var name:String
    var make:String
    var group:String
    var color:String
    var series:String
    var fuelType:String
    var fuelLevel:Double
    var transmission:String
    var licensePlate:String
    var latitude:Double?
    var longitude:Double?
    var innerCleanliness:String
    var carImageUrl:String
    
}
