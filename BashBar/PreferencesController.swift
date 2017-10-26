//
//  PreferencesController.swift
//  BashBar
//
//  Created by Tom Brek on 25/10/2017.
//  Copyright © 2017 Tom Brek. All rights reserved.
//

import Cocoa

class PreferencesController: NSWindowController {
    
    @IBOutlet weak var savePref: NSButton!
    @IBOutlet weak var cancelPref: NSButton!
    @IBOutlet weak var subMenu1: NSMenuItem!
    @IBOutlet weak var Menu1: NSMenuItem!
    @IBOutlet weak var sub1: NSButton!
    @IBOutlet weak var subMenu1_1: NSMenuItem!
    @IBOutlet weak var subMenu1_2: NSMenuItem!
    @IBOutlet weak var subMenu1_3: NSMenuItem!
    @IBOutlet weak var subMenu1_4: NSMenuItem!
    @IBOutlet weak var subMenu1_5: NSMenuItem!
    @IBOutlet weak var subMenu1_6: NSMenuItem!
    @IBOutlet weak var subMenu1_7: NSMenuItem!
    @IBOutlet weak var subMenu1_8: NSMenuItem!
    @IBOutlet weak var subMenu1_9: NSMenuItem!
    @IBOutlet weak var subMenu1_10: NSMenuItem!
    
    @IBOutlet weak var lab1_0: NSTextField!
    @IBOutlet weak var cmd1_0: NSTextField!
    @IBOutlet weak var lab1_1: NSTextField!
    @IBOutlet weak var cmd1_1: NSTextField!
    @IBOutlet weak var lab1_2: NSTextField!
    @IBOutlet weak var cmd1_2: NSTextField!
    @IBOutlet weak var lab1_3: NSTextField!
    @IBOutlet weak var cmd1_3: NSTextField!
    @IBOutlet weak var lab1_4: NSTextField!
    @IBOutlet weak var cmd1_4: NSTextField!
    @IBOutlet weak var lab1_5: NSTextField!
    @IBOutlet weak var cmd1_5: NSTextField!
    @IBOutlet weak var lab1_6: NSTextField!
    @IBOutlet weak var cmd1_6: NSTextField!
    @IBOutlet weak var lab1_7: NSTextField!
    @IBOutlet weak var cmd1_7: NSTextField!
    @IBOutlet weak var lab1_8: NSTextField!
    @IBOutlet weak var cmd1_8: NSTextField!
    @IBOutlet weak var lab1_9: NSTextField!
    @IBOutlet weak var cmd1_9: NSTextField!
    @IBOutlet weak var lab1_10: NSTextField!
    @IBOutlet weak var cmd1_10: NSTextField!
    @IBOutlet weak var lab1_11: NSTextField!
    @IBOutlet weak var cmd1_11: NSTextField!
    @IBOutlet weak var lab1_12: NSTextField!
    @IBOutlet weak var cmd1_12: NSTextField!
    @IBOutlet weak var lab1_13: NSTextField!
    @IBOutlet weak var cmd1_13: NSTextField!
    @IBOutlet weak var lab1_14: NSTextField!
    @IBOutlet weak var cmd1_14: NSTextField!
    @IBOutlet weak var lab1_15: NSTextField!
    @IBOutlet weak var cmd1_15: NSTextField!
    @IBOutlet weak var lab1_16: NSTextField!
    @IBOutlet weak var cmd1_16: NSTextField!
    @IBOutlet weak var lab1_17: NSTextField!
    @IBOutlet weak var cmd1_17: NSTextField!
    @IBOutlet weak var lab1_18: NSTextField!
    @IBOutlet weak var cmd1_18: NSTextField!
    @IBOutlet weak var lab1_19: NSTextField!
    @IBOutlet weak var cmd1_19: NSTextField!
    @IBOutlet weak var lab1_20: NSTextField!
    @IBOutlet weak var cmd1_20: NSTextField!
    @IBOutlet weak var lab1_21: NSTextField!
    @IBOutlet weak var cmd1_21: NSTextField!
    @IBOutlet weak var lab1_22: NSTextField!
    @IBOutlet weak var cmd1_22: NSTextField!
    @IBOutlet weak var lab1_23: NSTextField!
    @IBOutlet weak var cmd1_23: NSTextField!
    
    @IBAction func savePreferences(_ sender: Any) {
        subMenu1.title = lab1_0.stringValue
        Menu1.title = lab1_0.stringValue
        subMenu1_1.title = lab1_1.stringValue
        subMenu1_2.title = lab1_2.stringValue
        subMenu1_3.title = lab1_3.stringValue
        subMenu1_4.title = lab1_4.stringValue
        subMenu1_5.title = lab1_5.stringValue
        subMenu1_6.title = lab1_6.stringValue
        subMenu1_7.title = lab1_7.stringValue
        subMenu1_8.title = lab1_8.stringValue
        subMenu1_9.title = lab1_9.stringValue
        subMenu1_10.title = lab1_10.stringValue


    }
    
    
    
    
    @IBAction func subMenuCheck1(_ sender: Any) {
        subMenu1.isHidden = sub1.state == .on ? false : true
        Menu1.isHidden    = sub1.state == .on ? true : false
        lab1_1.isEnabled  = sub1.state == .on ? true : false
        cmd1_1.isEnabled  = sub1.state == .on ? true : false
        lab1_2.isEnabled  = sub1.state == .on ? true : false
        cmd1_2.isEnabled  = sub1.state == .on ? true : false
        lab1_3.isEnabled  = sub1.state == .on ? true : false
        cmd1_3.isEnabled  = sub1.state == .on ? true : false
        lab1_4.isEnabled  = sub1.state == .on ? true : false
        cmd1_4.isEnabled  = sub1.state == .on ? true : false
        lab1_5.isEnabled  = sub1.state == .on ? true : false
        cmd1_5.isEnabled  = sub1.state == .on ? true : false
        lab1_6.isEnabled  = sub1.state == .on ? true : false
        cmd1_6.isEnabled  = sub1.state == .on ? true : false
        lab1_7.isEnabled  = sub1.state == .on ? true : false
        cmd1_7.isEnabled  = sub1.state == .on ? true : false
        lab1_8.isEnabled  = sub1.state == .on ? true : false
        cmd1_8.isEnabled  = sub1.state == .on ? true : false
        lab1_9.isEnabled  = sub1.state == .on ? true : false
        cmd1_9.isEnabled  = sub1.state == .on ? true : false
        lab1_10.isEnabled  = sub1.state == .on ? true : false
        cmd1_10.isEnabled  = sub1.state == .on ? true : false
        lab1_11.isEnabled  = sub1.state == .on ? true : false
        cmd1_11.isEnabled  = sub1.state == .on ? true : false
        lab1_12.isEnabled  = sub1.state == .on ? true : false
        cmd1_12.isEnabled  = sub1.state == .on ? true : false
        lab1_13.isEnabled  = sub1.state == .on ? true : false
        cmd1_13.isEnabled  = sub1.state == .on ? true : false
        lab1_14.isEnabled  = sub1.state == .on ? true : false
        cmd1_14.isEnabled  = sub1.state == .on ? true : false
        lab1_15.isEnabled  = sub1.state == .on ? true : false
        cmd1_15.isEnabled  = sub1.state == .on ? true : false
        lab1_16.isEnabled  = sub1.state == .on ? true : false
        cmd1_16.isEnabled  = sub1.state == .on ? true : false
        lab1_17.isEnabled  = sub1.state == .on ? true : false
        cmd1_17.isEnabled  = sub1.state == .on ? true : false
        lab1_18.isEnabled  = sub1.state == .on ? true : false
        cmd1_18.isEnabled  = sub1.state == .on ? true : false
        lab1_19.isEnabled  = sub1.state == .on ? true : false
        cmd1_19.isEnabled  = sub1.state == .on ? true : false
        lab1_20.isEnabled  = sub1.state == .on ? true : false
        cmd1_20.isEnabled  = sub1.state == .on ? true : false
        lab1_21.isEnabled  = sub1.state == .on ? true : false
        cmd1_21.isEnabled  = sub1.state == .on ? true : false
        lab1_22.isEnabled  = sub1.state == .on ? true : false
        cmd1_22.isEnabled  = sub1.state == .on ? true : false
        lab1_23.isEnabled  = sub1.state == .on ? true : false
        cmd1_23.isEnabled  = sub1.state == .on ? true : false
    }
   
    override func windowDidLoad() {
        super.windowDidLoad()
    
        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    }

}
