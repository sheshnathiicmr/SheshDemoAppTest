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
    

    ///MARK:- Initialiser
    internal init(id: String, modelIdentifier:String, modelName:String, name:String, make:String, group:String, color:String, series:String, fuelType:String, fuelLevel:Double, transmission:String, licensePlate:String, latitude:Double?, longitude:Double?, innerCleanliness:String, carImageUrl:String) {
        self.id = id
        self.modelIdentifier = modelIdentifier
        self.modelName = modelName
        self.name = name
        self.make = make
        self.group = group
        self.color = color
        self.series = series
        self.fuelType = fuelType
        self.fuelLevel = fuelLevel
        self.transmission = transmission
        self.licensePlate = licensePlate
        self.latitude = latitude
        self.longitude = longitude
        self.innerCleanliness = innerCleanliness
        self.carImageUrl = carImageUrl
    }
    
    
}
