//
//  signUpViewController.swift
//  Turns
//
//  Created by Jesse Shawl on 6/3/15.
//  Copyright (c) 2015 Jesse Shawl. All rights reserved.
//

import UIKit

class signUpViewController: UIViewController {


    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBAction func signUp(sender: AnyObject) {
        var user = User(user: email.text, password: password.text)
        user.signUp({ (authenticationToken:String, userId:Int) in
            // authenticationToken
            NSOperationQueue.mainQueue().addOperationWithBlock {
               
                Token(userId: userId)
                self.presentingViewController?.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
            }
            
            }, errorcallback: { (error:String) in
                let alertController = UIAlertController(title: "Error", message: "\(error)", preferredStyle: .Alert)
                
                let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (action) in
                    // ...
                }
                alertController.addAction(cancelAction)
                
                let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in
                    // ...
                }
                alertController.addAction(OKAction)
                
                self.presentViewController(alertController, animated: true) {
                    // ...
                }
                
        })

    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func dismissModal(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
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
