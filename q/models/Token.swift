//
//  Token.swift
//  Turns
//
//  Created by Jesse Shawl on 5/30/15.
//  Copyright (c) 2015 Jesse Shawl. All rights reserved.
//

import UIKit

class Token: NSObject {
    init(userId:Int){
        if let deviceToken = NSUserDefaults.standardUserDefaults().objectForKey("token") as! String? {
            let params = [
                "device_token": "\(deviceToken)",
                "user_id": userId
            ] as [String:AnyObject]
        
        let request = NSMutableURLRequest(URL: NSURL(string: "\(Environment.getBaseURL())/tokens.json?authentication_token=\(currentUser!.authenticationToken!)")!)
        request.HTTPMethod = "POST"
        var err: NSError?
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.HTTPBody = NSJSONSerialization.dataWithJSONObject(params, options: nil, error: &err)
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            data, response, error in
          
            if error != nil {
                println("error=\(error)")
                return
            }
            
            let responseString = NSString(data: data, encoding: NSUTF8StringEncoding)
            var json: AnyObject! = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions(1), error: nil)
            if let response = json as? NSDictionary{
                println( response )
            }
        }
        task.resume()
        }
    }
}
