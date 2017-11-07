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
    @IBOutlet weak var errorMenu: NSMenuItem!
    let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
    
    // Fix Cut, Copy & Paste
   
    
    
    
    
    
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
    @IBOutlet weak var m_lab1_5: NSMenuItem!
    @IBOutlet weak var m_lab1_6: NSMenuItem!
    @IBOutlet weak var m_lab1_7: NSMenuItem!
    @IBOutlet weak var m_lab1_8: NSMenuItem!
    @IBOutlet weak var m_lab1_9: NSMenuItem!
    @IBOutlet weak var m_lab1_10: NSMenuItem!
    
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
    @IBOutlet weak var p_lab1_5: NSTextField!
    @IBOutlet weak var p_lab1_6: NSTextField!
    @IBOutlet weak var p_lab1_7: NSTextField!
    @IBOutlet weak var p_lab1_8: NSTextField!
    @IBOutlet weak var p_lab1_9: NSTextField!
    @IBOutlet weak var p_lab1_10: NSTextField!
    
    // Commands
    @IBOutlet weak var p_cmd1_0: NSTextField!
    @IBOutlet weak var p_cmd1_1: NSTextField!
    @IBOutlet weak var p_cmd1_2: NSTextField!
    @IBOutlet weak var p_cmd1_3: NSTextField!
    @IBOutlet weak var p_cmd1_4: NSTextField!
    @IBOutlet weak var p_cmd1_5: NSTextField!
    @IBOutlet weak var p_cmd1_6: NSTextField!
    @IBOutlet weak var p_cmd1_7: NSTextField!
    @IBOutlet weak var p_cmd1_8: NSTextField!
    @IBOutlet weak var p_cmd1_9: NSTextField!
    @IBOutlet weak var p_cmd1_10: NSTextField!
    
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
        let documentDirectory = NSSearchPathForDirectoriesInDomains(.applicationSupportDirectory, .userDomainMask, true)[0] as String
        let path = documentDirectory.appending("/com.tombrek.BashBar.plist")
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
        p_lab1_5.stringValue = plistData["p_lab1_5"] as! String
        p_cmd1_5.stringValue = plistData["p_cmd1_5"] as! String
        p_lab1_6.stringValue = plistData["p_lab1_6"] as! String
        p_cmd1_6.stringValue = plistData["p_cmd1_6"] as! String
        p_lab1_7.stringValue = plistData["p_lab1_7"] as! String
        p_cmd1_7.stringValue = plistData["p_cmd1_7"] as! String
        p_lab1_8.stringValue = plistData["p_lab1_8"] as! String
        p_cmd1_8.stringValue = plistData["p_cmd1_8"] as! String
        p_lab1_9.stringValue = plistData["p_lab1_9"] as! String
        p_cmd1_9.stringValue = plistData["p_cmd1_9"] as! String
        p_lab1_10.stringValue = plistData["p_lab1_10"] as! String
        p_cmd1_10.stringValue = plistData["p_cmd1_10"] as! String
        
        updateMenu1()
        
    }
    
    func savePropertyList() {
//        let fileManager = FileManager.default
        let documentDirectory = NSSearchPathForDirectoriesInDomains(.applicationSupportDirectory, .userDomainMask, true)[0] as String
        let path = documentDirectory.appending("/com.tombrek.BashBar.plist")
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
                          "p_cmd1_4": p_cmd1_4.stringValue ,
                          "p_lab1_5": p_lab1_5.stringValue ,
                          "p_cmd1_5": p_cmd1_5.stringValue ,
                          "p_lab1_6": p_lab1_6.stringValue ,
                          "p_cmd1_6": p_cmd1_6.stringValue ,
                          "p_lab1_7": p_lab1_7.stringValue ,
                          "p_cmd1_7": p_cmd1_7.stringValue ,
                          "p_lab1_8": p_lab1_8.stringValue ,
                          "p_cmd1_8": p_cmd1_8.stringValue ,
                          "p_lab1_9": p_lab1_9.stringValue ,
                          "p_cmd1_9": p_cmd1_9.stringValue ,
                          "p_lab1_10": p_lab1_10.stringValue ,
                          "p_cmd1_10": p_cmd1_10.stringValue
                        ] as [String : Any]
       
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
        p_lab1_5.isHidden  = checkbox1.state == .on ? false : true
        p_cmd1_5.isHidden  = checkbox1.state == .on ? false : true
        p_lab1_6.isHidden  = checkbox1.state == .on ? false : true
        p_cmd1_6.isHidden  = checkbox1.state == .on ? false : true
        p_lab1_7.isHidden  = checkbox1.state == .on ? false : true
        p_cmd1_7.isHidden  = checkbox1.state == .on ? false : true
        p_lab1_8.isHidden  = checkbox1.state == .on ? false : true
        p_cmd1_8.isHidden  = checkbox1.state == .on ? false : true
        p_lab1_9.isHidden  = checkbox1.state == .on ? false : true
        p_cmd1_9.isHidden  = checkbox1.state == .on ? false : true
        p_lab1_10.isHidden  = checkbox1.state == .on ? false : true
        p_cmd1_10.isHidden  = checkbox1.state == .on ? false : true
        
    }
    
    
    func updateMenu1() {
        
        // Tab
        menu1tab.label = p_lab1_0.stringValue
        
        // Menus
        m_lab1.title      = p_lab1_0.stringValue
        m_lab1.toolTip    = p_cmd1_0.stringValue
        m_lab1.isHidden   = (p_lab1_0.stringValue == "" || checkbox1.state == .on) ? true : false
        m_lab1_0.title    = p_lab1_0.stringValue
        m_lab1_0.isHidden = (p_lab1_0.stringValue == "" || checkbox1.state == .off) ? true : false
      
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
        m_lab1_5.title    = p_lab1_5.stringValue
        m_lab1_5.toolTip  = p_cmd1_5.stringValue
        m_lab1_5.isHidden = p_lab1_5.stringValue == "" ? true : false
        m_lab1_6.title    = p_lab1_6.stringValue
        m_lab1_6.toolTip  = p_cmd1_6.stringValue
        m_lab1_6.isHidden = p_lab1_6.stringValue == "" ? true : false
        m_lab1_7.title    = p_lab1_7.stringValue
        m_lab1_7.toolTip  = p_cmd1_7.stringValue
        m_lab1_7.isHidden = p_lab1_7.stringValue == "" ? true : false
        m_lab1_8.title    = p_lab1_8.stringValue
        m_lab1_8.toolTip  = p_cmd1_8.stringValue
        m_lab1_8.isHidden = p_lab1_8.stringValue == "" ? true : false
        m_lab1_9.title    = p_lab1_9.stringValue
        m_lab1_9.toolTip  = p_cmd1_9.stringValue
        m_lab1_9.isHidden = p_lab1_9.stringValue == "" ? true : false
        m_lab1_10.title    = p_lab1_10.stringValue
        m_lab1_10.toolTip  = p_cmd1_10.stringValue
        m_lab1_10.isHidden = p_lab1_10.stringValue == "" ? true : false
     
        
    }
    
    private func shell(_ args: String) {
//        if args.range(of:"sudo") != nil {
//            NSAppleScript(source: "do shell script \"sudo "+args+"\" with administrator privileges")!.executeAndReturnError(nil)
//        }
//        else {
//            NSAppleScript(source: "do shell script \""+args+"\"")!.executeAndReturnError(nil)
//        }
        var myAppleScript = "do shell script \""+args+"\""
        if args.range(of: "sudo") != nil {
            myAppleScript = myAppleScript + " with administrator privileges"
        }
        
        var error: NSDictionary?
        if let scriptObject = NSAppleScript(source: myAppleScript) {
            if let _: NSAppleEventDescriptor = scriptObject.executeAndReturnError(
                &error) {
                errorMenu.title = "Success"
//                print(output.stringValue)
            } else if (error != nil) {
                errorMenu.title = (error?.object(forKey: NSAppleScript.errorMessage) as! String)
                print((error?.object(forKey: NSAppleScript.errorMessage) as! String))
            }
        }
        
        
    }
    
    // Actions
    @IBAction func menuClicked(_ sender: NSMenuItem) {
        shell(sender.toolTip!)
    }

    // Cancel
    @IBAction func cancelClicked(_ sender: Any) {
        self.preferencesWindow.orderOut(self)
    }
    
    // Donate
    @IBAction func donateClicked(_ sender: Any) {
        NSWorkspace.shared.open(NSURL(string: "https://paypal.me/TBrek")! as URL)
    }
    
}
