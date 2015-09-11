//
//  Droppio.swift
//  Droppio
//
//  Created by Brian Egizi on 9/11/15.
//  Copyright (c) 2015 Droppio. All rights reserved.
//


import Foundation
import CoreLocation

// Define Library Constants

let DROPSCHEME = "http"
let DROPHOST = "localhost:3000"
let DROPVERSION = "v1"


public class Droppio {
    
    
    let session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
    
    public func publish(drop: Drop, completion: (success: Bool, error: NSError?) -> Void) {
        
        self.makeRequest("POST", path: "/drops", success: { (json) -> Void in
            print(json)
            
            // Unmarshal the response into the correct type
            
            completion(success: true, error: nil)
        })
    }
    
    public func fetchClosest(coordinate: CLLocationCoordinate2D, limit: Int, completion: (success: [Drop], error: NSError?) -> Void) {
        
        self.makeRequest("GET", path: "/drops", success: { (json) -> Void in
            print(json)
            
            // Unmarshal the response into the correct type
            
            completion(success: [], error: nil)
        })
    }
    
    
    
    //============================================//
    //      Private Request Helper Functions      //
    //============================================//
    
    private func buildURLFromPath(path: String) -> NSURL? {
        let c = NSURLComponents()
        c.scheme = DROPSCHEME
        c.host = DROPHOST
        c.path = "\(DROPVERSION)/\(path)"
        return c.URL
    }
    
    private func makeRequest(method: String, path: String, success: NSDictionary -> ()) {
        
        if let url = self.buildURLFromPath(path) {
            var request = NSMutableURLRequest(URL: url)
            
            switch method {
                case "POST":
                    request.HTTPMethod = "POST"
                    executeRequestTask(request, success: success)
                    break
                case "PUT":
                    request.HTTPMethod = "PUT"
                    break
                case "DELETE":
                    request.HTTPMethod = "DELETE"
                    break
                default:
                    request.HTTPMethod = "GET"
                    executeRequestTask(request, success: success)
                    break
            }
        } else {
            println("Failed to build URL")
        }
       
    }
    
    private func executeRequestTask(request: NSMutableURLRequest, success: NSDictionary -> ()) {
        var task = self.session.dataTaskWithRequest(request) { (data, response, error) -> Void in
            self.handleResponse(data, response: response as? NSHTTPURLResponse, error: error, success: success)
        }
        
        task.resume()
    }
    
    private func handleResponse(data: NSData!, response: NSHTTPURLResponse!, error: NSError!, success: NSDictionary -> ()) {
        // Unwrap error
        if let error = error {
            println("Error: \(error.localizedDescription)")
            return // early return if error
        }
        
        // If response comes back empty
        if response == nil {
            println("Error: No response from API")
            return // early return if empty
        }
        
        // Handle any error code that isn't 200 OK
        if response.statusCode != 200 {
            println("Error: Recieved status code \(response.statusCode) from API")
            return // early return if none 200 status code
        }
        
        var serializationError: NSError?
        
        var json: NSDictionary = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &serializationError) as! NSDictionary
        
        // Handle errors with serialization
        if let error = serializationError {
            println("Error: \(error.localizedDescription)")
            return // early return if failed to serialize
        }
        
        // Call callback with validated json object
        success(json)
        
    }
}