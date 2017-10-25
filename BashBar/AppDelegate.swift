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
    @IBOutlet weak var menuTable: NSTableView!
    
    var menu1Data = ["A"]
    var menu2Data = ["1"]
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        menuTable.beginUpdates()
        menuTable.insertRows(at: [IndexPath(row:1, section: 0)], withAnimation: .automatic)
        menuTable.endUpdates()
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

