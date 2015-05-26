//
//  Task.swift
//  q
//
//  Created by Jesse Shawl on 5/12/15.
//  Copyright (c) 2015 Jesse Shawl. All rights reserved.
//

import UIKit

class Task {
    var name:String?
    
    init( name:String, groupId:Int ,callback:(task: NSDictionary) -> Void){
        let request = NSMutableURLRequest(URL: NSURL(string: "\(Environment.getBaseURL())/groups/\(groupId)/tasks.json?authentication_token=\(currentUser!.authenticationToken!)")!)
        request.HTTPMethod = "POST"
        var err: NSError?
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let params = ["name":name] as [String:String]
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
                
                if response["id"] != nil {
                    println( response )
                    callback(task: response)
                } else {
                    //errorcallback(error: response["error"] as String)
                }
                
            }
        }
        task.resume()
    }
    class func destroy(groupId:Int, taskId:Int){
        let request = NSMutableURLRequest(URL: NSURL(string: "\(Environment.getBaseURL())/groups/\(groupId)/tasks/\(taskId).json?authentication_token=\(currentUser!.authenticationToken!)")!)
        request.HTTPMethod = "DELETE"
        var err: NSError?
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            data, response, error in
            
            if error != nil {
                println("error=\(error)")
                return
            }
            
            let responseString = NSString(data: data, encoding: NSUTF8StringEncoding)
            var json: AnyObject! = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions(1), error: nil)
            if let response = json as? NSDictionary{
                println(response)
            }
        }
        task.resume()

    
    }
    class func all(groupId:Int, goodcallback:(response:NSArray) -> Void, error:(error:NSError) -> Void ) {
        var url = NSURL(string: "\(Environment.getBaseURL())/groups/\(groupId)/tasks.json?authentication_token=\(currentUser!.authenticationToken!)")
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {(data, response, error) in
            var json: AnyObject! = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions(1), error: nil)
            if let response = json as? NSArray{
                goodcallback(response: response)
            }
            
        }
        task.resume()
    }
    class func nextUser(groupId:Int, taskId:Int, callback:(response:NSObject) -> Void, error:(error:NSError) -> Void){
        var url = NSURL(string: "\(Environment.getBaseURL())/groups/\(groupId)/tasks/\(taskId)/next_user.json?authentication_token=\(currentUser!.authenticationToken!)")
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {(data, response, error) in
            var json: AnyObject! = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions(1), error: nil)
            if let response = json as? NSObject{
                callback(response: response)
            }
            
        }
        task.resume()

    }

}
