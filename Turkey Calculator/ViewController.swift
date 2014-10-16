//
//  ViewController.swift
//  Turkey Calculator
//
//  Created by Ranjith Nagella on 10/14/14.
//  Copyright (c) 2014 Ranjith Nagella. All rights reserved.
//

import UIKit

extension Double {
    
    func toString() -> String {
        return String(format: "%.2f", self)
    }
}

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var turkeySizeLabel: UILabel!
    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var thawTimeLabel: UILabel!
    @IBOutlet weak var cookTimeLabel: UILabel!
    
    // default methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // assign delegate
        self.userTextField.delegate = self
        
        // set tetxfiled
        userTextField.text = "2"
        
        // calculate for 2 - default values
        // turkey size in Lbs - 1.5 times of person.
        let turkeySize = calculateTurkeySize(2.0) // lbs
        turkeySizeLabel.text = "\(turkeySize) lbs"
        
        // thaw time in days
        let thawTime =  calculateThawTime(2.0) // days
        thawTimeLabel.text = "\(thawTime) days"
        
        // cooking time in hours and minutes
        let cookTime =  convertHoursToStrings(convertMinutesToHours(calculateCookTime(2.0)))  // Hours
        cookTimeLabel.text = "\(cookTime)"
        
        // register for key strokes
        let notificationCenter = NSNotificationCenter.defaultCenter()
        notificationCenter.addObserver(self, selector: "textFieldTextChanged:", name: UITextFieldTextDidChangeNotification, object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        userTextField.resignFirstResponder()
        calculateData()
        return true
    }
    
    // listen for text change
    func textFieldTextChanged(sender: AnyObject) {
        println(userTextField.text)
        if userTextField.text.utf16Count > 0 {
            calculateData()
        }
    }
    
    
    // user defined functions
    
    func convertHoursToStrings(hours: Double) -> String {
        
        // returns as string (Hours: Minutes format)
        return hours.toString().componentsSeparatedByString(".")[0] + ":" + hours.toString().componentsSeparatedByString(".")[1] + " Hours"
    }
    
    func convertMinutesToHours(minutes: Double) -> Double {
        return minutes * 0.0166667 // 1 minute = 0.0166667 hours
    }
    
    func calculateTurkeySize(numberOfPersons: Double) -> Double {
        return numberOfPersons * 1.5
    }
    
    func calculateThawTime(numberOfPersons: Double) -> Double {
        return (numberOfPersons * 1.5) / 4 // days
    }
    
    func calculateCookTime(numberOfPersons: Double) -> Double {
        return numberOfPersons * 1.5 * 15 // mins
    }
    
    // Actions
    
    func calculateData() {
        
        let numberOfPersons: Int? = userTextField.text.toInt()
        
        
        if (numberOfPersons != nil) {
            // turkey size in Lbs - 1.5 times of person.
            let turkeySize = calculateTurkeySize(Double(numberOfPersons!)) // lbs
            turkeySizeLabel.text = "\(turkeySize) lbs"
            
            // thaw time in days
            let thawTime =  calculateThawTime(Double(numberOfPersons!)) // days
            thawTimeLabel.text = "\(thawTime) days"
            
            // cooking time in hours and minutes
            let cookTime =  convertHoursToStrings(convertMinutesToHours(calculateCookTime(Double(numberOfPersons!))))  // Hours
            cookTimeLabel.text = "\(cookTime)"
        }
    }

    @IBAction func calculateResults(sender: AnyObject) {
        
        // close the keypad if opened
        userTextField.resignFirstResponder()
        
        calculateData()
    }

    @IBAction func sliderButtonClicked(sender: UISlider) {
        let slider = Int(floor(sender.value))
        userTextField.text = "\(slider)"
        calculateData()
    }
}

