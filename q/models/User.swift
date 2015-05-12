//
//  User.swift
//  q
//
//  Created by Jesse Shawl on 5/7/15.
//  Copyright (c) 2015 Jesse Shawl. All rights reserved.
//

import Foundation

class User {
    var user:String?
    var password:String?
    var authenticationToken:String?
    init(user:String, password: String){
      self.user = user
      self.password = password
    }
    
    func login(goodcallback:(authenticationToken:String) -> Void, error:(error:NSError) -> Void ) {
        let request = NSMutableURLRequest(URL: NSURL(string: "http://localhost:3000/users/sign_in")!)
        request.HTTPMethod = "POST"
        var err: NSError?
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let params = ["user":["email":"j@j.com","password":"12345678"]] as [String:[String:String]]
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
                goodcallback(authenticationToken: response["authentication_token"] as String)
            }
        }
        task.resume()
    }
}

