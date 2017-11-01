//
//  StatusMenuController.swift
//  BashBar
//
//  Created by Tom Brek on 25/10/2017.
//  Copyright © 2017 Tom Brek. All rights reserved.
//

import Cocoa

class StatusMenuController: NSObject {
    
    @IBOutlet weak var preferencesView: NSView!
    @IBOutlet weak var preferencesWindow: NSWindow!
    @IBOutlet weak var bashMenu: NSMenu!
    
    let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
    
    override func awakeFromNib() {
        //        statusItem.title = "bashBar"
        //        statusItem.menu = bashMenu
        let icon = NSImage(named: NSImage.Name(rawValue: "statusIcon"))
        icon?.isTemplate = true // best for dark mode
        statusItem.image = icon
        statusItem.menu = bashMenu
        readPropertyList()
        updateMenu1()
        
        // Insert code here to initialize your application
    }
    // Quit app
    @IBAction func quitClicked(_ sender: NSMenuItem) {
        NSApplication.shared.terminate(self)
    }
    
    // Show preferences
    @IBAction func showPreferences(_ sender: Any) {
       // readPropertyList()
        self.preferencesWindow.orderFrontRegardless()
    }
    
    
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
        savePropertyList()
        self.preferencesWindow.orderOut(self)
    }
    
    // Update menu and label from plist
    func readPropertyList() {
        let fileManager = FileManager.default
        var propertyListFormat =  PropertyListSerialization.PropertyListFormat.xml //Format of the Property List.
        var plistData: [String: AnyObject] = [:] //Our data
        let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let path = documentDirectory.appending("/Config2.plist")
        if (!fileManager.fileExists(atPath: path)) {
            NSLog("Nie ma nic")
            savePropertyList()
        }
        let plistXML = FileManager.default.contents(atPath: path)!
        do {//convert the data to a dictionary and handle errors.
            plistData = try PropertyListSerialization.propertyList(from: plistXML, options: .mutableContainersAndLeaves, format: &propertyListFormat) as! [String:AnyObject]
            
        } catch {
            print("Error reading plist: \(error), format: \(propertyListFormat)")
        }
        
        // Update label
        checkbox1.state  = (plistData["checkbox1"] as! Bool) == true ? .on : .off
        self.checkbox1( 0 )
        p_lab1_0.stringValue = plistData["p_lab1_0"] as! String
        p_cmd1_0.stringValue = plistData["p_cmd1_0"] as! String
        p_lab1_1.stringValue = plistData["p_lab1_1"] as! String
        p_cmd1_1.stringValue = plistData["p_cmd1_1"] as! String
        p_lab1_2.stringValue = plistData["p_lab1_2"] as! String
        p_cmd1_2.stringValue = plistData["p_cmd1_2"] as! String
        p_lab1_3.stringValue = plistData["p_lab1_3"] as! String
        p_cmd1_3.stringValue = plistData["p_cmd1_3"] as! String
        p_lab1_4.stringValue = plistData["p_lab1_4"] as! String
        p_cmd1_4.stringValue = plistData["p_cmd1_4"] as! String
        
        updateMenu1()
        
    }
    
    func savePropertyList() {
//        let fileManager = FileManager.default
        let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let path = documentDirectory.appending("/Config2.plist")
        let dicContent = ["checkbox1": checkbox1.state,
                          "p_lab1_0": p_lab1_0.stringValue ,
                          "p_cmd1_0": p_cmd1_0.stringValue ,
                          "p_lab1_1": p_lab1_1.stringValue ,
                          "p_cmd1_1": p_cmd1_1.stringValue ,
                          "p_lab1_2": p_lab1_2.stringValue ,
                          "p_cmd1_2": p_cmd1_2.stringValue ,
                          "p_lab1_3": p_lab1_3.stringValue ,
                          "p_cmd1_3": p_cmd1_3.stringValue ,
                          "p_lab1_4": p_lab1_4.stringValue ,
                          "p_cmd1_4": p_cmd1_4.stringValue  ] as [String : Any]
       
        let plistData = NSDictionary(dictionary: dicContent)
        let success:Bool = plistData.write(toFile: path, atomically: true)
        if success {
            print("file has been created!")
        }else{
            print("unable to create the file")
        }
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
        m_lab1_2.isHidden = p_lab1_2.stringValue == "" ? true : false
        m_lab1_3.title    = p_lab1_3.stringValue
        m_lab1_3.toolTip  = p_cmd1_3.stringValue
        m_lab1_3.isHidden = p_lab1_3.stringValue == "" ? true : false
        m_lab1_4.title    = p_lab1_4.stringValue
        m_lab1_4.toolTip  = p_cmd1_4.stringValue
        m_lab1_4.isHidden = p_lab1_4.stringValue == "" ? true : false
        
    }
    
    private func shell(_ args: String) -> String {
        var outstr = ""
        let task = Process()
        task.launchPath = "/bin/sh sudo"
        task.arguments = ["-c", args]
        let pipe = Pipe()
        task.standardOutput = pipe
        task.launch()
        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        if let output = NSString(data: data, encoding: String.Encoding.utf8.rawValue) {
            outstr = output as String
        }
        task.waitUntilExit()
        NSLog(outstr)
        return outstr
    }
    
    // Actions
    
    @IBAction func m_lab1Clicked(_ sender: Any) {
        shell(p_cmd1_0.stringValue)
        
    }
    @IBAction func m_lab1_1Clicked(_ sender: Any) {
        shell("")
    }
    @IBAction func m_lab1_2Clicked(_ sender: Any) {
        shell("")
    }
    @IBAction func m_lab1_3Clicked(_ sender: Any) {
        shell("")
    }
    @IBAction func m_lab1_4Clicked(_ sender: Any) {
        shell("")
    }
    
    
    
}
