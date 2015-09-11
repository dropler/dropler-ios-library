//
//  NetworkStub.swift
//  Droppio
//
//  Created by Brian Egizi on 9/11/15.
//  Copyright (c) 2015 Droppio. All rights reserved.
//

import Foundation

class NetworkStub :NSURLProtocol {
    
    static var statusCode :Int = 200
    static var headerFields :[NSObject : AnyObject] = ["content-type" : "application/json"]
    static var responseString :String = "{\"key\" : 5}"
    
    override static func canInitWithRequest(request: NSURLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequestForRequest(request: NSURLRequest) -> NSURLRequest {
        return request
    }
    
    
    override func startLoading() {
        let response = NSHTTPURLResponse(URL: request.URL!, statusCode: NetworkStub.statusCode, HTTPVersion: "2.0", headerFields: NetworkStub.headerFields)
        client?.URLProtocol(self, didReceiveResponse: response!, cacheStoragePolicy: .NotAllowed)
        
        let data = (NetworkStub.responseString as NSString).dataUsingEncoding(NSUTF8StringEncoding)!
        
        client?.URLProtocol(self, didLoadData: data)
        client?.URLProtocolDidFinishLoading(self)
    }
}