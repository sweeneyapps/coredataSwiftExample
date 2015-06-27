//
//  DataViewController.swift
//  database
//
//  Created by Paul Sweeney Jr on 6/4/15.
//  Copyright (c) 2015 Paul Sweeney Jr. All rights reserved.
//

import UIKit

class DataViewController: UITableViewController, UITableViewDataSource {
    
    var fetchObj : [AnyObject] = []
    var managedObjectContext : NSManagedObjectContext?
    var underAge : Bool?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var app = UIApplication.sharedApplication().delegate as! AppDelegate

        managedObjectContext = app.managedObjectContext!
        fetchLoad()
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        fetchLoad()
        self.tableView.reloadData()
    }
 
    
    func fetchLoad() {
        
        var entity = NSEntityDescription.entityForName("Person", inManagedObjectContext:managedObjectContext!)
        
        var fetch = NSFetchRequest()
        fetch.entity = entity
        // for fun  who's greater than 18
        if let ageMatter = underAge {
            if ageMatter == false { fetch.predicate = NSPredicate(format: "age > 18") }
        }
        
        // sort
        fetch.sortDescriptors = [NSSortDescriptor(key: "age", ascending: true)]
        
        
        fetchObj = managedObjectContext!.executeFetchRequest(fetch, error: nil)!
        
        println("fetch Loading : \(fetchObj.count) objects")

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
        return fetchObj.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("listingCell", forIndexPath: indexPath) as! UITableViewCell
        
        var name = fetchObj[indexPath.row].name
        var age = fetchObj[indexPath.row].age
        var sex = fetchObj[indexPath.row].sex
        var city = fetchObj[indexPath.row].city
        
        cell.textLabel!.text = "\(name)"
            
        cell.detailTextLabel!.text = "\(age), \(sex), \(city)"
        
        
        cell.backgroundColor = fetchObj[indexPath.row].colorLabel
        
        

        // Configure the cell...

        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
       return true
    }


    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            
            var deletedItem = fetchObj[indexPath.row] as! Person
            managedObjectContext!.deleteObject(deletedItem)
            managedObjectContext!.save(nil)
            fetchLoad()
            
            
            
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
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
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "add" {
            
            println("add clicked")
            
        } else {
        
        var editViewCtrl = segue.destinationViewController as! EditViewController
        
        var row = self.tableView.indexPathForSelectedRow()!.row
        println(row)
        var selectedObj = fetchObj[row] as! Person
        editViewCtrl.selectedObj = selectedObj
        
        }
        
    }
    

}
