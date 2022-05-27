//
//  Cab.swift
//  RideCell
//
//  Created by ityx  on 26/05/22.
//

import Foundation

class Cab: Equatable {
    
    static func == (lhs: Cab, rhs: Cab) -> Bool {
        return lhs.id == rhs.id
    }
    
    
    ///MARK:- Properties
    var id:Int
    var isActive:Bool
    var isAvailable:Bool
    var lat : Double?
    var lng : Double?
    var licensePlateNumber:String
    var pool:String
    var remainingMileage:Int
    var remainingRangeInMeters:Int?
    var transmissionMode:String?
    var vehicleMake:String
    var vehiclePic:String
    var vehiclePicAbsoluteUrl:String
    var vehicleType:String
    var vehicleTypeId:Int
    
    ///MARK:- Initialiser
    internal init(id: Int, isActive: Bool, isAvailable: Bool, lat: Double?, lng: Double?, licensePlateNumber: String, pool: String, remainingMileage: Int, remainingRangeInMeters: Int?, transmissionMode: String?, vehicleMake: String, vehiclePic: String, vehiclePicAbsoluteUrl: String, vehicleType: String, vehicleTypeId: Int) {
        self.id = id
        self.isActive = isActive
        self.isAvailable = isAvailable
        self.lat = lat
        self.lng = lng
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
