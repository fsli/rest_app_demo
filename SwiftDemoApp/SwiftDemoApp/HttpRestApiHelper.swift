//
//  HttpRestApiHelper.swift
//  SwiftDemoApp
//
//  Created by Ferris Li on 12/23/15.
//  Copyright © 2015 Ferris Li. All rights reserved.
//

import Foundation

class HttpRestApiHelper {
    struct config {
        static let host = "http://boiling-ocean-2662.herokuapp.com"
        static let boundary = "SwiftDemoAppBoundaryTzYLhPmTVdBxf5kO"
    }
    class func getUsersApiUrl() -> String {
        let ret  = config.host + "/api/v1/users/"
        return ret
    }
    
    class func getFilesApiUrl() -> String {
        let ret  = config.host + "/api/v1/files/"
        return ret
    }
    
    class func getImageUrl(filename: String) -> String {
        if (filename.isEmpty) {
            return ""
        }
        let ret = config.host + "/upload/" + filename
        return ret
    }
    
    class func get(url: String,  completionHandler : (result: NSObject!) -> Void) {
        let nsUrl = NSURL(string: url)
        let request = NSMutableURLRequest(URL: nsUrl!)
        let session = NSURLSession.sharedSession()
        request.HTTPMethod = "GET"
        
        
        
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
    
    class func uploadPngFile(url: String, pngData: NSData, completionHandler : (result: NSObject!) -> Void) {
        let nsUrl = NSURL(string: url)
        let request = NSMutableURLRequest(URL: nsUrl!)
        let session = NSURLSession.sharedSession()
        let contentType = "multipart/form-data; boundary=" + config.boundary
        let boundaryStart = "--\(config.boundary)\r\n"
        let boundaryEnd = "--\(config.boundary)--\r\n"
        let fieldName = "fileUpload"
        let fileName = "upload.png"
        let mimeType = "image/png"
        let contentDispositionString = "Content-Disposition: form-data; name=\"\(fieldName)\"; filename=\"\(fileName)\"\r\n"
        let mimeTypeString = "Content-Type: \(mimeType)\r\n\r\n"
        request.HTTPMethod = "POST"
        request.addValue(contentType, forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let requestBodyData : NSMutableData = NSMutableData()
        requestBodyData.appendData(boundaryStart.dataUsingEncoding(NSUTF8StringEncoding)!)
        requestBodyData.appendData(contentDispositionString.dataUsingEncoding(NSUTF8StringEncoding)!)
        requestBodyData.appendData(mimeTypeString.dataUsingEncoding(NSUTF8StringEncoding)!)
        requestBodyData.appendData(pngData)
        requestBodyData.appendData("\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
        requestBodyData.appendData(boundaryEnd.dataUsingEncoding(NSUTF8StringEncoding)!)

        request.HTTPBody = requestBodyData
        
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