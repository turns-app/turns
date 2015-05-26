//
//  EventsTableViewController.swift
//  q
//
//  Created by Jesse Shawl on 5/12/15.
//  Copyright (c) 2015 Jesse Shawl. All rights reserved.
//

import UIKit

class EventsTableViewController: UITableViewController, UITableViewDelegate, UITableViewDataSource {
    var groupId:Int?
    var taskId:Int?
    var events:[AnyObject]? = []
    
    @IBOutlet weak var sendReminderButton: UIButton!
    @IBAction func sendReminder(sender: AnyObject) {
        
    }
    @IBAction func newEvent(sender: AnyObject) {
        Event(groupId: self.groupId!, taskId: self.taskId!, callback: { (response: NSDictionary) -> Void in
            self.events?.append(response)
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.tableView!.reloadData()
            })
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Task.nextUser(groupId!,taskId: taskId!, callback: { (response:NSDictionary) -> Void in
            
            if var user = response["email"] as? String{
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.sendReminderButton.setTitle("Remind \(user)", forState: UIControlState.Normal)
                })
              
            }
            
            }, error: { (error: NSError) -> Void in
                println(error)
        })
        Event.all( self.groupId!, taskId: self.taskId!, goodcallback: { (response) -> Void in
            self.events = response as! [NSDictionary]
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.tableView!.reloadData()
            })
            }, error: { (error) -> Void in
                //
        })

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
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
        return events!.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("eventRow", forIndexPath: indexPath) as! UITableViewCell

        // Configure the cell...
        let name = self.events![indexPath.row]["user_email"]! as! String
        let at = self.events![indexPath.row]["created_at"]! as! String
        // Configure the cell...
        cell.textLabel!.text = name
        cell.detailTextLabel!.text = at
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
