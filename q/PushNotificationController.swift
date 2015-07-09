//
//  PushNotificationController.swift
//  Turns
//
//  Created by Jesse Shawl on 6/30/15.
//  Copyright (c) 2015 Jesse Shawl. All rights reserved.
//

import Foundation

class PushNotificationController : NSObject {
    
    override init() {
        super.init()
        let parseApplicationId = valueForAPIKey(keyname: "PARSE_APPLICATION_ID")
        let parseClientKey     = valueForAPIKey(keyname: "PARSE_CLIENT_KEY")
        
        Parse.setApplicationId(parseApplicationId, clientKey: parseClientKey)
    }
    
}