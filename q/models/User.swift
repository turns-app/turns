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
    init(user:String, password: String){
      self.user = user
      self.password = password
    }
    
    func login(goodcallback:(authenticationToken:String) -> Void, error:(error:NSError) -> Void ) {
        // login
        //callback(response: JSON ) ^^
            goodcallback(authenticationToken: "authtoke")
        
    }
}

class fakeUse {
    
    func start() {
        let user = User(user: "", password: "")
        
        user.login({ (authenticationToken:String) in
            // authenticationToken
        }, error: { (error:NSError) in
            
        })
        
    }
    
}