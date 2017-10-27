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
    @IBOutlet weak var subLabel1: NSTextField!
    @IBOutlet weak var subCmd1: NSTextField!
    @IBOutlet weak var subMenu1_1: NSMenuItem!
    @IBOutlet weak var subMenu1_2: NSMenuItem!

    @IBOutlet weak var menu1tab: NSTabViewItem!
    @IBOutlet weak var p_lab1_0: NSTextField!
    @IBOutlet weak var p_cmd1_0: NSTextField!
    @IBOutlet weak var p_lab1_1: NSTextField!
    @IBOutlet weak var p_cmd1_1: NSTextField!
    @IBOutlet weak var p_lab1_2: NSTextField!
    @IBOutlet weak var p_cmd1_2: NSTextField!
  
    @IBAction func savePreferences(_ sender: Any) {
        updateMenu1()
    }
    
    
    
    
    @IBAction func subMenuCheck1(_ sender: Any) {
        subMenu1.isHidden = sub1.state == .on ? false : true
        Menu1.isHidden    = sub1.state == .on ? true : false
        subLabel1.isHidden = sub1.state == .on ? false : true
        subCmd1.isHidden = sub1.state == .on ? false : true
        p_lab1_1.isHidden  = sub1.state == .on ? false : true
        p_cmd1_1.isHidden  = sub1.state == .on ? false : true
        p_lab1_2.isHidden  = sub1.state == .on ? false : true
        p_cmd1_2.isHidden  = sub1.state == .on ? false : true

    }
   
    override func windowDidLoad() {
        super.windowDidLoad()
    
        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    }
    func updateMenu1() {
        subMenu1.title = p_lab1_0.stringValue
        subMenu1.toolTip = p_cmd1_0.stringValue
        Menu1.title = p_lab1_0.stringValue
        Menu1.toolTip = p_cmd1_0.stringValue
        menu1tab.label = p_lab1_0.stringValue
        subMenu1_1.title = p_lab1_1.stringValue
        subMenu1_1.toolTip = p_cmd1_1.stringValue
        subMenu1_1.isHidden = p_subMenu1_1.title == "" ? true : false
        subMenu1_2.title = p_lab1_2.stringValue
        subMenu1_2.isHidden = p_subMenu1_2.title == "" ? true : false
    }
}
