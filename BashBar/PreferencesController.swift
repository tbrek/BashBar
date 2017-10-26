//
//  PreferencesController.swift
//  BashBar
//
//  Created by Tom Brek on 25/10/2017.
//  Copyright © 2017 Tom Brek. All rights reserved.
//

import Cocoa

class PreferencesController: NSWindowController {

    @IBOutlet weak var sub1: NSButton!
    
    @IBOutlet weak var label1_0: NSTextField!
    @IBOutlet weak var cmd1_0: NSTextField!
    @IBOutlet weak var label1_1: NSTextField!
    @IBOutlet weak var cmd1_1: NSTextField!
    @IBOutlet weak var label1_2: NSTextField!
    @IBOutlet weak var cmd1_2: NSTextField!
    @IBOutlet weak var label1_3: NSTextField!
    @IBOutlet weak var cmd1_3: NSTextField!
    @IBOutlet weak var subCheck1: NSButton!
    
    @IBAction func subMenuCheck1(_ sender: Any) {
        label1_1.isEnabled = Bool(subCheck1.state)
        
    }
   
    override func windowDidLoad() {
        super.windowDidLoad()
    
        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    }

}
