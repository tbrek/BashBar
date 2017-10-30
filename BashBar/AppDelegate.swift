//
//  AppDelegate.swift
//  BashBar
//
//  Created by Tom Brek on 24/10/2017.
//  Copyright © 2017 Tom Brek. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    var Preferences = PreferencesController()
    @IBOutlet weak var preferencesWindow: NSWindow!

    @IBOutlet weak var p_lab1_0: NSTextField!
    @IBAction func sub1_1action(_ sender: Any) {
    }
    

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    

}

