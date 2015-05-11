//
//  AuthenticationsViewController.swift
//  q
//
//  Created by Jesse Shawl on 5/7/15.
//  Copyright (c) 2015 Jesse Shawl. All rights reserved.
//

import UIKit

class AuthenticationsViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    @IBAction func login(sender: AnyObject) {
        var user = User(user: email.text, password: password.text)
        user.login({ (authenticationToken:String) in
            // authenticationToken
            println("logged in!")
            }, error: { (error:NSError) in
                println("error!")
            })
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
