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
    class func all(groupId:Int, goodcallback:(response:NSArray) -> Void, error:(error:NSError) -> Void ) {
        var url = NSURL(string: "http://localhost:3000/groups/\(groupId)/tasks.json?authentication_token=\(currentUser!.authenticationToken!)")
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {(data, response, error) in
            var json: AnyObject! = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions(1), error: nil)
            if let response = json as? NSArray{
                goodcallback(response: response)
            }
            
        }
        
        
        task.resume()
    }

}
