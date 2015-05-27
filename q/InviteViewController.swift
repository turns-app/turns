//
//  InviteViewController.swift
//  q
//
//  Created by Jesse Shawl on 5/27/15.
//  Copyright (c) 2015 Jesse Shawl. All rights reserved.
//

import UIKit

class InviteViewController: UIViewController {

  
    @IBAction func dismissInvite(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    @IBOutlet weak var inviteCodeLabel: UILabel!
    var inviteCode:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        inviteCodeLabel.text = self.inviteCode!
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
