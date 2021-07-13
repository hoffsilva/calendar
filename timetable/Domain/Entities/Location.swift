//
//  Location.swift
//  timetable
//
//  Created by Hoff Silva on 03/06/21.
//

struct Location: Hashable {
    
    let latitude: Double
    let longitude: Double
    
    init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
    
}
