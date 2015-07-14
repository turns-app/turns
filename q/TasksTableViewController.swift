//
//  TasksTableViewController.swift
//  q
//
//  Created by Jesse Shawl on 5/12/15.
//  Copyright (c) 2015 Jesse Shawl. All rights reserved.
//

import UIKit

class TasksTableViewController: UITableViewController, UITableViewDataSource, UITableViewDelegate {
    var groupId:Int?
    var groupName:String?
    var inviteCode:String?
    var tasks:[AnyObject]? = []
    var staticRows = [
        "Invite to "
    ]
    
    @IBAction func new(sender: AnyObject) {
        var alert = UIAlertController(title: "New Task", message: "Enter a task name", preferredStyle: .Alert)
        
        //2. Add the text field. You can configure it however you need.
        alert.addTextFieldWithConfigurationHandler({ (textField) -> Void in
            textField.text = ""
        })
        alert.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: { (action) -> Void in
        }))
        
        //3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
            let textField = alert.textFields![0] as! UITextField
            Task(name: textField.text, groupId: self.groupId!, callback: { (task) -> Void in
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.tasks!.append(task)
                    self.tableView.reloadData()
                })
            })
        }))
        
        
        
        // 4. Present the alert.
        self.presentViewController(alert, animated: true, completion: nil)
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        Task.all( self.groupId!, goodcallback: { (response) -> Void in
            self.tasks = response as [AnyObject]
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.tableView!.reloadData()
            })
            }, error: { (error) -> Void in
                //
        })

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 2
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        switch(section){
        case 0:
            return self.tasks!.count
        case 1:
            return staticRows.count
        default:
            return 1
        }

    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var rowIdentifier = ""
        var title = ""
        switch (indexPath.section) {
        case 0:
            rowIdentifier = "taskRow"
            title = self.tasks![indexPath.row]["name"] as! String
            break;
        case 1:
            rowIdentifier = "inviteToGroupRow"
            title = "Invite to \(self.groupName!)";
            break;
        default:
            rowIdentifier = "taskRow"
            title = ":("
            break;
        }
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
            let taskId:Int = self.tasks![indexPath.row]["id"]! as! Int
            Task.destroy(self.groupId!, taskId: taskId)
            tasks?.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    /**/

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

        if segue.identifier == "showTask" {
            let indexPath = self.tableView!.indexPathForSelectedRow()
            let taskId = self.tasks![indexPath!.row]["id"]
            let taskName = self.tasks![indexPath!.row]["name"]
            let vc = segue.destinationViewController as! EventsTableViewController
            vc.groupId = groupId as Int?
            vc.taskName = taskName as! String?
            vc.taskId = taskId as! Int?
        } else if segue.identifier == "inviteToGroup" {
            let indexPath = self.tableView!.indexPathForSelectedRow()
            let vc = segue.destinationViewController as! InviteViewController
            vc.inviteCode = self.inviteCode as String?
        }
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
  

}
