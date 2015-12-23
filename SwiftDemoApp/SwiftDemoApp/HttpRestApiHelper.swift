//
//  HttpRestApiHelper.swift
//  SwiftDemoApp
//
//  Created by Ferris Li on 12/23/15.
//  Copyright © 2015 Ferris Li. All rights reserved.
//

import Foundation

class HttpRestApiHelper {
    class func post(url: String, postdata: NSObject ,  completionHandler : (result: NSObject!) -> Void) {
        let nsUrl = NSURL(string: url)
        let request = NSMutableURLRequest(URL: nsUrl!)
        let session = NSURLSession.sharedSession()
        request.HTTPMethod = "POST"
    
        
        do {
            request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(postdata, options: NSJSONWritingOptions.PrettyPrinted)
            
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            
            let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
                print("Response: \(response)")
                let strData = NSString(data: data!, encoding: NSUTF8StringEncoding)
                print("Body: \(strData)")
                do {
                let nsObj = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableLeaves) as? NSObject
                    completionHandler(result: nsObj!)


                }catch let error as NSError {
                    print(error.localizedDescription)
                    let jsonStr = NSString(data: NSKeyedArchiver.archivedDataWithRootObject(data!)
, encoding: NSUTF8StringEncoding)
                    print("Error could not parse JSON: '\(jsonStr)'")
                    completionHandler(result: nil)
                }
            })
            task.resume()
        } catch let error as NSError {
            print("json error: \(error.localizedDescription)")
        }
        
    }
    
    class func put(url: String, postdata: NSObject ,  completionHandler : (result: NSObject!) -> Void) {
        let nsUrl = NSURL(string: url)
        let request = NSMutableURLRequest(URL: nsUrl!)
        let session = NSURLSession.sharedSession()
        request.HTTPMethod = "PUT"
        
        
        do {
            request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(postdata, options: NSJSONWritingOptions.PrettyPrinted)
            
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            
            let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
                print("Response: \(response)")
                let strData = NSString(data: data!, encoding: NSUTF8StringEncoding)
                print("Body: \(strData)")
                do {
                    let nsObj = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableLeaves) as? NSObject
                    completionHandler(result: nsObj!)
                    
                    
                }catch let error as NSError {
                    print(error.localizedDescription)
                    let jsonStr = NSString(data: NSKeyedArchiver.archivedDataWithRootObject(data!)
                        , encoding: NSUTF8StringEncoding)
                    print("Error could not parse JSON: '\(jsonStr)'")
                    completionHandler(result: nil)
                }
            })
            task.resume()
        } catch let error as NSError {
            print("json error: \(error.localizedDescription)")
        }
        
    }
    
    class func delete(url: String, completionHandler : (result: NSObject!) -> Void) {
        let nsUrl = NSURL(string: url)
        let request = NSMutableURLRequest(URL: nsUrl!)
        let session = NSURLSession.sharedSession()
        request.HTTPMethod = "DELETE"
        
        
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            print("Response: \(response)")
            let strData = NSString(data: data!, encoding: NSUTF8StringEncoding)
            print("Body: \(strData)")
            do {
                let nsObj = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableLeaves) as? NSObject
                completionHandler(result: nsObj!)
                
            }catch let error as NSError {
                print(error.localizedDescription)
                let jsonStr = NSString(data: NSKeyedArchiver.archivedDataWithRootObject(data!)
                    , encoding: NSUTF8StringEncoding)
                print("Error could not parse JSON: '\(jsonStr)'")
                completionHandler(result: nil)
            }
        })
        task.resume()
        
        
    }
}