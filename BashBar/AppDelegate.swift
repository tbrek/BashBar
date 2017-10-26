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
    
    @IBOutlet weak var preferencesWindow: NSWindow!

    
    var menu1Data = ["A"]
    var menu2Data = ["1"]
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
   
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

