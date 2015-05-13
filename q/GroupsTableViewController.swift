//
//  GroupsTableViewController.swift
//  q
//
//  Created by Jesse Shawl on 5/12/15.
//  Copyright (c) 2015 Jesse Shawl. All rights reserved.
//

import UIKit

class GroupsTableViewController: UITableViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var table: UITableView!
    var groups:[AnyObject]? = []
    override func viewDidLoad() {
        super.viewDidLoad()
        Group.all( { (response) -> Void in
            self.groups = response
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.table.reloadData()
            })
        }, error: { (error) -> Void in
        //
        })
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
        let cell = tableView.dequeueReusableCellWithIdentifier("groupRow", forIndexPath: indexPath) as UITableViewCell
        let name = self.groups![indexPath.row]["name"]! as String
        // Configure the cell...
        cell.textLabel!.text = name
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
            groups?.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            //delete request
            Group.destroy(indexPath.row)
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
        let vc = segue.destinationViewController as TasksTableViewController
        vc.groupId = groupId as Int?
        
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }

}
