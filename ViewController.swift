//
//  ViewController.swift
//  Tip-Calculator
//
//  Created by Luis Mendez on 8/3/18.
//  Copyright © 2018 Luis Mendez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //All labels that make up the calculator app
    @IBOutlet weak var settingBtn: UIBarButtonItem!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var TIP: UILabel!
    
    //Labels for the total these amount of people have to pay each
    @IBOutlet weak var twoPeople: UILabel!
    @IBOutlet weak var threePeople: UILabel!
    @IBOutlet weak var fourPeople: UILabel!
    @IBOutlet weak var fivePeople: UILabel!
    
    //To show how many people will have to pay that specific amount
    @IBOutlet weak var twoStar: UILabel!
    @IBOutlet weak var threeStar: UILabel!
    @IBOutlet weak var fourStar: UILabel!
    @IBOutlet weak var fiveStar: UILabel!
    
    //Top and bottom views
    @IBOutlet weak var topBackground: UIView!
    @IBOutlet weak var bottomBackground: UIView!
    
    var timeAppWasLastUsed: Double = 0 //has to be initialize otherwise error
    var timer: Timer?//variable to be used with the time the app was last used, by either touching segemented control for the tip or entering bill amount
    
    /*******************************************
     * UIVIEW CONTROLLER LIFECYCLES FUNCTIONS *
     *******************************************/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        print("viewDidLoad")
        
        has10minutesPassed()//checks if 10 mins have passed if so delete bill amount cookie/userDefaults
        setAllColors()//set all labels views colors
        
        //These two labels will be hidden on Load in case it's an Iphone shorter than iPhoneX
        //These are here because of the 10 min bill persistence, if there is data then
        //all fields will be displayed except these 2
        self.fivePeople.alpha = 0
        self.fiveStar.alpha = 0
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("view will appear")
        // This is a good place to retrieve the default tip percentage from UserDefaults
        // and use it to update the tip amount
        
        // Access UserDefaults
        let defaults = UserDefaults.standard
        
        // Get a Double value.
        let tip = defaults.integer(forKey: "TIP")
        tipControl.selectedSegmentIndex = tip;//Selected index you want;
        
        //////////////background color change light/dark mode/////////////////////
        
        // Get bool value if dark theme is set or not
        let isDarkTheme = defaults.bool(forKey: "isDarkTheme")
        
        if(isDarkTheme){
            topBackground.backgroundColor = #colorLiteral(red: 0, green: 0.2684682608, blue: 0.4762560725, alpha: 1)
            bottomBackground.backgroundColor = #colorLiteral(red: 0.1215686277, green: 0.1294117719, blue: 0.1411764771, alpha: 1)
            tipControl.tintColor = #colorLiteral(red: 0.1215686277, green: 0.1294117719, blue: 0.1411764771, alpha: 1)//borders and active index will be changed
        }
        else {
            topBackground.backgroundColor = #colorLiteral(red: 0.2388094664, green: 0.659204483, blue: 0.664686501, alpha: 1)
            bottomBackground.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
            tipControl.tintColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)//borders and active index will be changed
        }
        
    }
  
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("view did appear")
        
        //Step 4: Make sure the keyboard is always visible and the bill amount is always the first responder.
        billField.becomeFirstResponder()
        
        //to remove it use
            //yourTextField.resignFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("view will disappear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("view did disappear")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*******************************************
     * FUNCTIONS I CREATED TO HELP IBActions *
     *******************************************/
    
    //This function checks if 10 mins have passed if so delete bill amount cookie/userDefaults
    func has10minutesPassed(){
        let currentDateTime = NSDate()
        
        // Access UserDefaults
        let defaults = UserDefaults.standard
        //print("begins has10minutesPassed")
        //print(currentDateTime)
        
        // if initialDateTime is not nil, note: cannot print nil values will give error but we can compare them.
        if(defaults.object(forKey: "initialDateTime") != nil){
            let initialDateTime = defaults.object(forKey: "initialDateTime") as! NSDate
            let interval = currentDateTime.timeIntervalSince(initialDateTime as Date)
            //print(interval)
            
            // If interval is greater than 10 minutes, billAmount cookie/userDefault is deleted
            if(interval > 600){
                defaults.removeObject(forKey: "billAmount")
            }
            else {
                //if billAmount exists then set billField text with the bill Amount from when app was closed
                if(defaults.string(forKey: "billAmount") != nil){
                    billField.text = defaults.string(forKey: "billAmount")

                }
            }
        }
        
         //Call this function on load to set labels whether we have billAmount cookie/userDefault or not
         self.calculatorTip(self)//To pass a self sender, indicating that it wasn't called through the usual framework.
        
        //Set the date value for some key.
        defaults.set(currentDateTime, forKey: "initialDateTime")
        
        //Force UserDefaults to save.
        defaults.synchronize()
    }
    
    //This function will set all text and background color on load from viewdidload
    func setAllColors(){
        
        //This code gets rid of the border-bottom from navigation bar, but can't use barTintColor anymore
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        //Navigation Bar Text:
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.font: UIFont(name: "Courier-Bold", size: 19)!,NSAttributedStringKey.foregroundColor: UIColor.white]
        
        //billField.textColor = .white
        settingBtn.setTitleTextAttributes([
            NSAttributedStringKey.foregroundColor: UIColor.white
            ], for: .normal)
        
        billField.textColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
        message.textColor = .white
        totalLabel.textColor = .white
        tipLabel.textColor = .white
        TIP.textColor = .white
        
        twoPeople.textColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
        threePeople.textColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
        fourPeople.textColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
        fivePeople.textColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
        
        twoStar.textColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
        threeStar.textColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
        fourStar.textColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
        fiveStar.textColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
        
        //To change the text color of an individual segmented control, call setTitleTextAttributes directly on the segmented control object:
        tipControl.setTitleTextAttributes([
            NSAttributedStringKey.foregroundColor: UIColor.white
            ], for: .normal)
        
        //for the active UISegmentedControl
        tipControl.setTitleTextAttributes([
            NSAttributedStringKey.foregroundColor: UIColor.white
            ], for: .selected)
    }
    
    //Step 1: This function will reset all values in the app back to zero after 10 min of being unused
    func timerFunc() {
        
        //the ? means if it's not empty
        timer?.invalidate()//Invalidate the previous call if it's not empty and set it again to 600 secs = 10 mins
        
        //set timer for 10 mins and put back everything to nil
        timer = Timer.scheduledTimer(withTimeInterval: 600, repeats: false){
            timer in
            self.billField.text! = ""
            self.tipLabel.text = String(format: "$%.2f", 0)
            self.totalLabel.text = String(format: "$%.2f", 0)
            
            // Access UserDefaults
            let defaults = UserDefaults.standard
            
            // Get the Double value.
            let tip = defaults.integer(forKey: "TIP")
            self.tipControl.selectedSegmentIndex = tip;
            self.isBillEmpty()//has any value been input in the bill text field
            
        }//after 10 min set textbox to empty
        //btw NSTimer became Timer
        
        //print("inside timerFunc")
        
    }
    
    //This function will make items visible or invisible to the eye when bill input is empty or not
    func isBillEmpty() {
        
        //print("Inside isBillEmpty")
        
        var isShorterThanIphoneX = false
        //The height of a 2436 is for iphone X so anything
        //below a the iphone X do not show the fifth person
        //if we using anything below the iPhone X screens set it to true
        if UIDevice().userInterfaceIdiom == .phone {
            if UIScreen.main.nativeBounds.height < 2400 {
                isShorterThanIphoneX = true
                //print("true")
            }
        }
        
        if(billField.text == ""){
            UIView.animate(withDuration: 0.0, delay: 0.0, options: UIViewAnimationOptions.curveEaseOut, animations: {
                
                self.tipControl.alpha = 0
                self.tipLabel.alpha = 0
                
                self.twoPeople.alpha = 0
                self.threePeople.alpha = 0
                self.fourPeople.alpha = 0
                self.fivePeople.alpha = 0
                
                self.twoStar.alpha = 0
                self.threeStar.alpha = 0
                self.fourStar.alpha = 0
                self.fiveStar.alpha = 0
                
                self.TIP.alpha = 0
                
            }, completion: nil)
            
            UIView.animate(withDuration: 0.2, delay: 0.1, options: UIViewAnimationOptions.curveEaseIn, animations: {
                self.message.alpha = 1//Show the message hide the other labels
            }, completion: nil)
        }
        else {
            
            UIView.animate(withDuration: 0.0, delay: 0.0, options: UIViewAnimationOptions.curveEaseOut, animations: {
                
                self.message.alpha = 0//Hide message show the other labels
                
           }, completion: nil)
            
            UIView.animate(withDuration: 0.1, delay: 0.0, options: UIViewAnimationOptions.curveEaseIn, animations: {
                self.tipControl.alpha = 1
                self.tipLabel.alpha = 1
                
                self.twoPeople.alpha = 1
                self.threePeople.alpha = 1
                self.fourPeople.alpha = 1
                
                self.twoStar.alpha = 1
                self.threeStar.alpha = 1
                self.fourStar.alpha = 1
                
                self.TIP.alpha = 1
                
                //if using shorter phones than iPhone X then do not show fifth person or else it will be
                //close to the edge and overlapping the bottom edge
                if(!isShorterThanIphoneX){
                    self.fivePeople.alpha = 1
                    self.fiveStar.alpha = 1
                }
                
            }, completion: nil)
        }
    }
    
    /**********************
     * IBACTION FUNCTIONS *
     *********************/
    
    @IBAction func calculatorTip(_ sender: Any) {
        
        isBillEmpty()//has any value been input in the bill text field
        timerFunc()//call function to keep track of time the app was last modified by the user
        
        //Step 2: Use locale specific currency and currency thousands separator
        let numberFormatter = NumberFormatter()
        numberFormatter .usesGroupingSeparator = true
        numberFormatter.numberStyle = .currency
        numberFormatter.locale = Locale.current
        
        let tipPercentages = [0.18, 0.2, 0.22]
        
        let bill = Double(billField.text!) ?? 0
        let tipDouble = bill * tipPercentages[tipControl.selectedSegmentIndex]
        let totalDouble = bill + tipDouble
        
        //tipLabel.text = String(format: "$%.2f", tipDouble)
        //totalLabel.text = String(format: "$%.2f", totalDouble)
        
        var tipNSNumber: NSNumber?
        var totalNSNumber: NSNumber?
        
        var twoPeopleNSNumber: NSNumber?
        var threePeopleNSNumber: NSNumber?
        var fourPeopleNSNumber: NSNumber?
        var fivePeopleNSNumber: NSNumber?
        
        tipNSNumber = NSNumber(value: tipDouble)
        totalNSNumber = NSNumber(value: totalDouble)
        
        twoPeopleNSNumber = NSNumber(value: totalDouble/2)
        threePeopleNSNumber = NSNumber(value: totalDouble/3)
        fourPeopleNSNumber = NSNumber(value: totalDouble/4)
        fivePeopleNSNumber = NSNumber(value: totalDouble/5)
        
        tipLabel.text = numberFormatter.string(from: tipNSNumber!)
        totalLabel.text = numberFormatter.string(from: totalNSNumber!)
        
        twoPeople.text = numberFormatter.string(from: twoPeopleNSNumber!)
        threePeople.text = numberFormatter.string(from: threePeopleNSNumber!)
        fourPeople.text = numberFormatter.string(from: fourPeopleNSNumber!)
        fivePeople.text = numberFormatter.string(from: fivePeopleNSNumber!)
        
        //set userDefaults for when app restarts to call it in viewDidLoad
        
        // Access UserDefaults
        let defaults = UserDefaults.standard
        
        // Set an string value for some key.
        defaults.set(billField.text, forKey: "billAmount")
        
        // Force UserDefaults to save.
        defaults.synchronize()
    }
    
    //when tap anywhere keyboard hides
    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)
    }
}

