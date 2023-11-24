//
//  Services.swift
//  pruebaearthquakes
//
//  Created by Manuel Venegas Celis on 23-11-23.
//

import Foundation


struct apiService {
    
    static let getListEarthQuakes = DefaultServicesStruct(url: "https://earthquake.usgs.gov/fdsnws/event/1/query?format=geojson&starttime=2020-01-01&endtime=2020-01-02", method: .get, contentType: .urlEncode)
    
}

public struct DefaultServicesStruct{
    var url: String
    var method: requestType
    var contentType: contentType
}

public enum contentType: String {
    case json = "application/json"
    case urlEncode = "application/x-www-form-urlencoded"
}
