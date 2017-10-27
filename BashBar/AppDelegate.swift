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

    @IBAction func sub1_1action(_ sender: Any) {
    }
    
    func readPropertyList() {
        var propertyListFormat =  PropertyListSerialization.PropertyListFormat.xml //Format of the Property List.
        var plistData: [String: AnyObject] = [:] //Our data
        let plistPath: String? = Bundle.main.path(forResource: "Config", ofType: "plist")! //the path of the data
        let plistXML = FileManager.default.contents(atPath: plistPath!)!
        do {//convert the data to a dictionary and handle errors.
            plistData = try PropertyListSerialization.propertyList(from: plistXML, options: .mutableContainersAndLeaves, format: &propertyListFormat) as! [String:AnyObject]
            
        } catch {
            print("Error reading plist: \(error), format: \(propertyListFormat)")
        }
      //  lab1_0.stringValue = plistData["lab1_0"] as! String
      //  cmd1_0.stringValue = plistData["cmd1_0"] as! String
        
        
    }
    
    
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        readPropertyList()
        
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

