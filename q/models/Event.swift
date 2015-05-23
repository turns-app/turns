//
//  Event.swift
//  q
//
//  Created by Jesse Shawl on 5/12/15.
//  Copyright (c) 2015 Jesse Shawl. All rights reserved.
//

import Foundation

class Event: NSObject {
    var name:String?
    
    init(groupId:Int, taskId: Int, callback:(response: NSArray) -> Void){
        
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

}
