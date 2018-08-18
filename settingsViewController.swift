//
//  settingsViewController.swift
//  Tip-Calculator
//
//  Created by Luis Mendez on 8/5/18.
//  Copyright © 2018 Luis Mendez. All rights reserved.
//

import UIKit

class settingsViewController: UIViewController {
    
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var switchDarkTheme: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("view will appear")
        // This is a good place to retrieve the default tip percentage from UserDefaults
        // and use it to update the tip amount
        
        // Access UserDefaults
        let defaults = UserDefaults.standard
        
        // Get a bool value.
        let tip = defaults.integer(forKey: "TIP")
        tipControl.selectedSegmentIndex = tip;//Selected index you want;
        
        // if true
        if(defaults.bool(forKey: "isDarkTheme")){
            switchDarkTheme.setOn(true, animated:true)
        }
        else {
            switchDarkTheme.setOn(false, animated:true)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    @IBAction func setTipValue(_ sender: Any) {
        
        let tipIndex = tipControl.selectedSegmentIndex
        
        //Access UserDefaults
        let defaults = UserDefaults.standard
        
        // Set a Double value for some key.
        defaults.set(tipIndex, forKey: "TIP")
        
        // Force UserDefaults to save.
        defaults.synchronize()
    }
    
    @IBAction func setDarkTheme(_ sender: Any) {
        
        let darkTheme = switchDarkTheme.isOn
        print("inside set dark theme")
        print(darkTheme)
        
        //Access UserDefaults
        let defaults = UserDefaults.standard
        
        // Set a Double value for some key.
        defaults.set(darkTheme , forKey: "isDarkTheme")
        
        // Force UserDefaults to save.
        defaults.synchronize()
    }
}
