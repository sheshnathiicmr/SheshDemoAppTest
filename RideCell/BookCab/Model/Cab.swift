//
//  Cab.swift
//  RideCell
//
//  Created by ityx  on 26/05/22.
//

import Foundation

class Cab {
    
    ///MARK:- Properties
    var id:String
    var isActive:Bool
    var isAvailable:Bool
    var lat : Float
    var lag : Float
    var licensePlateNumber:String
    var pool:String
    var remainingMileage:Int
    var remainingRangeInMeters:Int
    var transmissionMode:String
    var vehicleMake:String
    var vehiclePic:String
    var vehiclePicAbsoluteUrl:String
    var vehicleType:String
    var vehicleTypeId:String
    
    ///MARK:- Initializer
    internal init(id: String, isActive: Bool, isAvailable: Bool, lat: Float, lag: Float, licensePlateNumber: String, pool: String, remainingMileage: Int, remainingRangeInMeters: Int, transmissionMode: String, vehicleMake: String, vehiclePic: String, vehiclePicAbsoluteUrl: String, vehicleType: String, vehicleTypeId: String) {
        self.id = id
        self.isActive = isActive
        self.isAvailable = isAvailable
        self.lat = lat
        self.lag = lag
        self.licensePlateNumber = licensePlateNumber
        self.pool = pool
        self.remainingMileage = remainingMileage
        self.remainingRangeInMeters = remainingRangeInMeters
        self.transmissionMode = transmissionMode
        self.vehicleMake = vehicleMake
        self.vehiclePic = vehiclePic
        self.vehiclePicAbsoluteUrl = vehiclePicAbsoluteUrl
        self.vehicleType = vehicleType
        self.vehicleTypeId = vehicleTypeId
    }
    
    
}
