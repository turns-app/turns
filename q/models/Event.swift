//
//  Event.swift
//  q
//
//  Created by Jesse Shawl on 5/12/15.
//  Copyright (c) 2015 Jesse Shawl. All rights reserved.
//

import Foundation
import Parse

class Event: NSObject {
    var name:String?
    
    init(groupId:Int, taskId: Int, callback:(response: NSDictionary) -> Void){
        let request = NSMutableURLRequest(URL: NSURL(string: "\(Environment.getBaseURL())/groups/\(groupId)/tasks/\(taskId)/events.json?authentication_token=\(currentUser!.authenticationToken!)")!)
        request.HTTPMethod = "POST"
        var err: NSError?
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let params = ["":""]
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
                    
                    callback(response: response)
                } else {
                    //errorcallback(error: response["error"] as String)
                }
                
            }
        }
        task.resume()

    }
    class func all(groupId:Int, taskId:Int, goodcallback:(response:NSArray) -> Void, error:(error:NSError) -> Void ) {
        var url = NSURL(string: "\(Environment.getBaseURL())/groups/\(groupId)/tasks/\(taskId)/events.json?authentication_token=\(currentUser!.authenticationToken!)")
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {(data, response, error) in
            var json: AnyObject! = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions(1), error: nil)
            if let response = json as? NSArray{
                goodcallback(response: response)
            }
            
        }
        
        
        task.resume()
    }
    
    class func notify(userToken:String?, taskId:Int?, taskName:String){
        println("here")
        println(userToken)
        let pushMessage = "It's your turn to \(taskName)!"
        
        // Create our Installation query
        let token = userToken
        var pushQuery:PFQuery? = PFInstallation.query()
        pushQuery!.whereKey("deviceToken", equalTo:token!)
        
        // Send push notification to query
        var pushNotification:PFPush? = PFPush()
        pushNotification!.setQuery(pushQuery)
        pushNotification!.setData([
            "sound":"alert.caf",
            "alert":pushMessage
            ])
        pushNotification!.sendPushInBackgroundWithBlock({ (succeeded,e) -> Void in
            
            if succeeded {
                println("Push message to query in background succeeded")
            }
            if let error = e {
                println("Error:  (error.localizedDescription)")
            }
        })
    }

}
