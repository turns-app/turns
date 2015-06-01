//
//  GroupsTableViewController.swift
//  q
//
//  Created by Jesse Shawl on 5/12/15.
//  Copyright (c) 2015 Jesse Shawl. All rights reserved.
//

import UIKit

class GroupsTableViewController: UITableViewController, UITableViewDataSource, UITableViewDelegate {
    
    var staticRows = [
      "Join Existing Group"
    ]
    
    @IBAction func logout(sender: AnyObject) {
       currentUser = nil
       NSUserDefaults.standardUserDefaults().setObject(nil, forKey: "authentication_token")
       self.viewDidLoad()
    }
    
   
    
    @IBOutlet var table: UITableView!
    var groups:[AnyObject]? = []
    
    @IBAction func newGroup(sender: AnyObject) {
        
        var alert = UIAlertController(title: "New Group", message: "Enter a group name", preferredStyle: .Alert)
        alert.addTextFieldWithConfigurationHandler({ (textField) -> Void in
            textField.text = ""
        })
        alert.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: { (action) -> Void in
        }))
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
            let textField = alert.textFields![0] as! UITextField
            Group(name: textField.text, callback: { (group) -> Void in
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.groups!.append(group)
                    self.table.reloadData()
                })
            })
        }))
        
        
        
        // 4. Present the alert.
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let authToken = NSUserDefaults.standardUserDefaults().objectForKey("authentication_token") as! String?
        
        if authToken == nil {
            let authView = self.storyboard?.instantiateViewControllerWithIdentifier("authView") as! AuthenticationsViewController
            authView.sendingView = self
            self.presentViewController(authView, animated: true, completion: nil)
            
        } else {
            currentUser = User(user: "",password:"")
            currentUser!.authenticationToken = authToken
            Group.all( { (response) -> Void in
                self.groups = response as [AnyObject]
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.table.reloadData()
                })
            }, error: { (error) -> Void in
            //
            })
        }
    }

    func didReceiveMemoryWarninrg() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
        
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return self.groups!.count
    }

   
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
      
        var rowIdentifier = ""
        var title = ""
        rowIdentifier = "groupRow"
        title = (self.groups![indexPath.row]["name"] as? String)!;
        let cell = tableView.dequeueReusableCellWithIdentifier("\(rowIdentifier)", forIndexPath: indexPath) as! UITableViewCell
        cell.textLabel!.text = title
        return cell
    }
   

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    
   
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            let groupId:Int = self.groups![indexPath.row]["id"]! as! Int
            Group.destroy(groupId)
            groups?.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            //delete request
            
            //Group.destroy(groups[indexPath.row!])
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }


    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */


    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let indexPath = self.table.indexPathForSelectedRow()
        let groupId = self.groups![indexPath!.row]["id"]
        let inviteCode = self.groups![indexPath!.row]["invite"]
        let vc = segue.destinationViewController as! TasksTableViewController
        vc.groupId = groupId as! Int?
        vc.groupName = self.groups![indexPath!.row]["name"] as! String? 
        vc.inviteCode = inviteCode as! String?
    }
    
    override func viewWillAppear(animated: Bool) {
        if (self.navigationItem.hidesBackButton || self.navigationItem.rightBarButtonItem != nil) {
            self.navigationController!.navigationBar.setNeedsLayout()
        }
    }

}
