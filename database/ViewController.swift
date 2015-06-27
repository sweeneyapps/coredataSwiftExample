//
//  ViewController.swift
//  database
//
//  Created by Paul Sweeney Jr on 6/4/15.
//  Copyright (c) 2015 Paul Sweeney Jr. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
  
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "18andUP") {
            var dataVC = segue.destinationViewController as! DataViewController
            dataVC.underAge = false
            println("underAge set to false")
        }
        
        
        // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }



}

