//
//  PreferencesController.swift
//  BashBar
//
//  Created by Tom Brek on 25/10/2017.
//  Copyright © 2017 Tom Brek. All rights reserved.
//

import Cocoa

class PreferencesController: NSWindowController {
    
    // Checkboxes
    @IBOutlet weak var checkbox1: NSButton!
    
    // Buttons
    @IBOutlet weak var savePref: NSButton!
    @IBOutlet weak var cancelPref: NSButton!
    
    // Menus
    @IBOutlet weak var m_lab1: NSMenuItem!
    @IBOutlet weak var m_lab1_0: NSMenuItem!
    @IBOutlet weak var m_lab1_1: NSMenuItem!
    @IBOutlet weak var m_lab1_2: NSMenuItem!
    @IBOutlet weak var m_lab1_3: NSMenuItem!
    @IBOutlet weak var m_lab1_4: NSMenuItem!
    
    // Tabs
    @IBOutlet weak var menu1tab: NSTabViewItem!
    
    // Labels
    @IBOutlet weak var Label1_1: NSTextField!
    @IBOutlet weak var Command1_0: NSTextField!
    @IBOutlet weak var Command1_1: NSTextField!
    
    
    // Names
    @IBOutlet weak var p_lab1_0: NSTextField!
    @IBOutlet weak var p_lab1_1: NSTextField!
    @IBOutlet weak var p_lab1_2: NSTextField!
    @IBOutlet weak var p_lab1_3: NSTextField!
    @IBOutlet weak var p_lab1_4: NSTextField!
    
    // Commands
    @IBOutlet weak var p_cmd1_0: NSTextField!
    @IBOutlet weak var p_cmd1_1: NSTextField!
    @IBOutlet weak var p_cmd1_2: NSTextField!
    @IBOutlet weak var p_cmd1_3: NSTextField!
    @IBOutlet weak var p_cmd1_4: NSTextField!
  
    @IBAction func savePreferences(_ sender: Any) {
        updateMenu1()
    }
    
    
    
    
    @IBAction func checkbox1(_ sender: Any) {
        
        // Update Menu
        m_lab1_0.isHidden = checkbox1.state == .on ? false : true
        m_lab1.isHidden    = checkbox1.state == .on ? true : false
        
        // Hide/Show Labels
        Label1_1.isHidden = checkbox1.state == .on ? false : true
        Command1_0.isHidden = checkbox1.state == .on ? true : false
        Command1_1.isHidden = checkbox1.state == .on ? false : true
        
        // Hide/Show Fields
        p_cmd1_0.isHidden  = checkbox1.state == .on ? true : false
        p_lab1_1.isHidden  = checkbox1.state == .on ? false : true
        p_cmd1_1.isHidden  = checkbox1.state == .on ? false : true
        p_lab1_2.isHidden  = checkbox1.state == .on ? false : true
        p_cmd1_2.isHidden  = checkbox1.state == .on ? false : true
        p_lab1_3.isHidden  = checkbox1.state == .on ? false : true
        p_cmd1_3.isHidden  = checkbox1.state == .on ? false : true
        p_lab1_4.isHidden  = checkbox1.state == .on ? false : true
        p_cmd1_4.isHidden  = checkbox1.state == .on ? false : true

    }
   
    override func windowDidLoad() {
        super.windowDidLoad()
    
        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    }
    func updateMenu1() {
        // Menus
        m_lab1.title      = p_lab1_0.stringValue
        m_lab1.toolTip    = p_cmd1_0.stringValue
        m_lab1_0.title    = p_lab1_0.stringValue
        // Submenus
        m_lab1_1.title    = p_lab1_1.stringValue
        m_lab1_1.toolTip  = p_cmd1_1.stringValue
        m_lab1_1.isHidden = p_lab1_1.stringValue == "" ? true : false
        m_lab1_2.title    = p_lab1_2.stringValue
        m_lab1_2.toolTip  = p_cmd1_2.stringValue
        m_lab1_2.isHidden = p_lab1_1.stringValue == "" ? true : false
        m_lab1_3.title    = p_lab1_3.stringValue
        m_lab1_3.toolTip  = p_cmd1_3.stringValue
        m_lab1_3.isHidden = p_lab1_1.stringValue == "" ? true : false
        m_lab1_4.title    = p_lab1_4.stringValue
        m_lab1_4.toolTip  = p_cmd1_4.stringValue
        m_lab1_4.isHidden = p_lab1_1.stringValue == "" ? true : false
        
    }
}
