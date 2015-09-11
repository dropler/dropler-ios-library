//
//  Drop.swift
//  Droppio
//
//  Created by Brian Egizi on 9/11/15.
//  Copyright (c) 2015 Droppio. All rights reserved.
//

import Foundation
import CoreLocation

public class Drop {
    var coordinate :CLLocationCoordinate2D
    var radius :CLLocationDistance
    
    public init(coordinate: CLLocationCoordinate2D, radius: CLLocationDistance) {
        self.coordinate = coordinate
        self.radius = radius
    }
}