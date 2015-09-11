//
//  DroppioTests.swift
//  DroppioTests
//
//  Created by Brian Egizi on 9/11/15.
//  Copyright (c) 2015 Droppio. All rights reserved.
//

import UIKit
import XCTest
import CoreLocation

class DroppioTests: XCTestCase {
    
    override func setUp() {
        let status = NSURLProtocol.registerClass(NetworkStub.self) ? "ok" : "not ok"
        print("protocol registered : \(status)")
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        NSURLProtocol.unregisterClass(NetworkStub.self)
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        let drop = Droppio()
        
        drop.publish(Drop(coordinate: CLLocationCoordinate2DMake(0, 0), radius: 50.0 as CLLocationDistance), completion: { (success, error) -> Void in
            
        })
    }
    
    func testPerformanceExample() {
        
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }
    
}
