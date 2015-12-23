//
//  UserTableViewController.swift
//  SwiftDemoApp
//
//  Created by Ferris Li on 12/20/15.
//  Copyright (c) 2015 Ferris Li. All rights reserved.
//

import UIKit

class UserTableViewController: UITableViewController {
    //MARK: properties
    var users = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadUsers()
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
        return users.count + 1
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        // Configure the cell...
        let cellIdentifier = "UserTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! UserTableViewCell
        if (indexPath.row  == 0) {
            cell.idLabel.text = ""
            cell.usernameText.text =  ""
            cell.saveButton.hidden = false
            cell.saveButton.tag = 0
            cell.saveButton.setTitle("Add", forState:UIControlState.Normal)
            cell.deleteButton.hidden = true
        } else if (indexPath.row  <= users.count) {
            let user = self.users[indexPath.row - 1]
            cell.idLabel.text = String(user.id)
            cell.usernameText.text =  user.username
            cell.saveButton.hidden = false
            cell.saveButton.tag = user.id
            cell.deleteButton.addTarget(self, action: "onDeleteButtonTouchUpInside:", forControlEvents: UIControlEvents.TouchUpInside)
            cell.deleteButton.hidden = false
            cell.deleteButton.tag = user.id
        }
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

    @IBAction func onSaveButtonTouchUpInside(sender: UIButton) {
        
        let view = sender.superview!
        let cell = view.superview as? UserTableViewCell
        let username = cell?.usernameText.text
        if (sender.tag == 0 && username?.isEmpty != true) {
            addUser(username!)
        } else if (sender.tag > 0 && username?.isEmpty != true) {
            saveUser(sender.tag, username: username!)
        }
    }
    
    func onDeleteButtonTouchUpInside(sender: UIButton) {
        let userId = sender.tag
        deleteUser(userId)
    }
    //MARK: data loading functions
    func loadUsers() {
        
        let url : String = "http://boiling-ocean-2662.herokuapp.com/api/v1/users"
        HttpRestApiHelper.get(url) { (result : NSObject!) in
            self.users = [User]()
            if let rows = result as? NSArray {
                for i in 0 ... rows.count - 1 {
                    let row = rows[i] as! NSDictionary
                    let id = row["id"] as! Int
                    let username = row["username"] as! String
                    let user = User(id: id, username: username)
                    self.users.append(user!)
                }
            }
            dispatch_async(dispatch_get_main_queue(), {
                self.tableView!.reloadData()
            })
        }
    }
        
    func addUser(username: String) {
        if (username.isEmpty == true) {
            return
        }
        let strUrl : String = "http://boiling-ocean-2662.herokuapp.com/api/v1/users"
        let nsPostdata : NSDictionary = ["username": username]
        HttpRestApiHelper.post(strUrl, postdata: nsPostdata) {(result: NSObject!) in
            if let data = result as? NSDictionary {
                let id = data["id"]
                print("user id : \(id) has been created.")
                self.loadUsers()
            }
        }
    }
    
    func saveUser(userId: Int, username: String) {
        if (username.isEmpty == true) {
            return
        }
        let strUrl : String = "http://boiling-ocean-2662.herokuapp.com/api/v1/users/" + String(userId)
        let nsPostdata : NSDictionary = ["username": username]
        HttpRestApiHelper.put(strUrl, postdata: nsPostdata) {(result: NSObject!) in
            if let data = result as? NSDictionary {
                let id = data["id"]
                print("user id : \(id) has been updated.")
                self.loadUsers()
            }
        }
    }
    
    func deleteUser(userId: Int) {
        let strUrl : String = "http://boiling-ocean-2662.herokuapp.com/api/v1/users/" + String(userId)
        HttpRestApiHelper.delete(strUrl) {(result: NSObject!) in
            if let data = result as? NSDictionary {
                let id = data["id"]
                print("user id : \(id) has been deleted.")
                self.loadUsers()
            }
        }
    }
}
