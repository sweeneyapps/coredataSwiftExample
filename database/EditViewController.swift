//
//  EditViewController.swift
//  database
//
//  Created by Paul Sweeney Jr on 6/4/15.
//  Copyright (c) 2015 Paul Sweeney Jr. All rights reserved.
//

import UIKit

func PickerHelper(picker: UIPickerView, string: String, row: Int) {
    var theView = picker.viewForRow(row, forComponent: 0)
    if let aView = theView {
        aView.frame.size = CGSizeMake(30, 30)
    var label = UILabel(frame: aView.frame)
    label.text = string
     aView.addSubview(label)
        if row == 0 { aView.backgroundColor = UIColor.redColor() }
        if row == 1 { aView.backgroundColor = UIColor.blueColor() }
        if row == 2 { aView.backgroundColor = UIColor.greenColor() }
    }
}

class EditViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var selectedObj : Person?
    
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var age: UITextField!
    @IBOutlet weak var sex: UITextField!
    @IBOutlet weak var city: UITextField!
    @IBOutlet weak var colorPicker: UIPickerView! {
        didSet {
            colorPicker.delegate = self
            colorPicker.dataSource = self
        }
    }
    var selectedColor: UIColor? = nil
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let modelObj = selectedObj {
            name.text = modelObj.name
            age.text = "\(modelObj.age)"
            sex.text = modelObj.sex
            city.text = modelObj.city
            selectedColor = modelObj.colorLabel
            
               var row = 0
       
            if modelObj.colorLabel == UIColor.redColor() {
                  row = 0
            } else if modelObj.colorLabel == UIColor.greenColor() {
                   row = 1
            } else if modelObj.colorLabel == UIColor.blueColor() {
                   row = 2
            }
            
            println("selected: \(row)")
            
            colorPicker.selectRow(row, inComponent: 0, animated: false)
        }
        
    
         colorPicker.reloadAllComponents()
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveData(sender: AnyObject) {
        var app = UIApplication.sharedApplication().delegate as! AppDelegate
        var context = app.managedObjectContext!
        
        if let modelObj = selectedObj { // if selected for Editing
            modelObj.name = name.text
            modelObj.age = age.text.toInt()
            modelObj.city = city.text
            modelObj.sex = sex.text
            modelObj.colorLabel = selectedColor ?? UIColor.blackColor()
        }
        else { // New Record
             var entity = NSEntityDescription.entityForName("Person", inManagedObjectContext: context)
            
            var modelObj = Person(entity: entity!, insertIntoManagedObjectContext: context)
            
            if name.text != "" && age.text != "" && city.text != "" && sex.text != "" {
                modelObj.name = name.text
                modelObj.age = age.text.toInt()
                modelObj.city = city.text
                modelObj.sex = sex.text
                modelObj.colorLabel = selectedColor ?? UIColor.blackColor()
                
            } else {
                modelObj.name = "Blank"
                modelObj.age = 0
                modelObj.city = "Blank"
                modelObj.sex = "Blank"
                modelObj.colorLabel = UIColor.blackColor()
            }
        
        }
        
        var error : NSError?
                if(!context.save(&error)) {
                  println("couldn't save bec:  \(error?.localizedDescription)")
                } else {
                   
                    println("saved")
                    
                    self.navigationController?.popViewControllerAnimated(true)
                
        }


        
    }
    
    // MARK: - Picker DataSource
    
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
      
        return 1
    }
    
    func pickerView(pickerView: UIPickerView,
        numberOfRowsInComponent component: Int) -> Int {
            
         return 3
            
    }
    
    
    
    
    // MARK: - Picker Delegate
    
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView!) -> UIView {
      var aView = UIView(frame: CGRectMake(0, 0, 100, 40))
        var label = UILabel(frame: aView.frame)
        if row == 0 { label.text = "Red"
         aView.backgroundColor = UIColor.redColor() }
        if row == 1 { label.text = "Green"
         aView.backgroundColor = UIColor.greenColor() }
        if row == 2 { label.text = "Blue"
         aView.backgroundColor = UIColor.blueColor() }
        aView.addSubview(label)
        return aView
                    
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if row == 0 { selectedColor = UIColor.redColor() }
        if row == 1 { selectedColor = UIColor.greenColor() }
        if row == 2 { selectedColor = UIColor.blueColor() }
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
