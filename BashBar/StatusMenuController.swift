//
//  StatusMenuController.swift
//  BashBar
//
//  Created by Tom Brek on 25/10/2017.
//  Copyright © 2017 Tom Brek. All rights reserved.
//

import Cocoa
import ServiceManagement


class StatusMenuController: NSObject {
    
    @IBOutlet weak var tailLogsCheckbox: NSButton!
    @IBOutlet weak var resultsWindow: NSPanel!
    @IBOutlet weak var closeResults: NSButton!
    @IBOutlet weak var preferencesView: NSView!
    @IBOutlet var resultsView: NSTextView!
    @IBOutlet weak var preferencesWindow: NSWindow!
    @IBOutlet weak var bashMenu: NSMenu!
    @IBOutlet weak var errorMenu: NSMenuItem!
    @IBOutlet weak var commandpromptItem: NSMenuItem!
    let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
    var plistData: [String: AnyObject] = [:]
    var path: String!
    var documentDirectory: String!
    
    override func awakeFromNib() {
        //        statusItem.title = "bashBar"
        //        statusItem.menu = bashMenu
        let icon = NSImage(named: "statusIcon")
        icon?.isTemplate = true // best for dark mode
        statusItem.image = icon
        statusItem.menu = bashMenu
        let commandpromptstatusicon = NSImage(named: "commandprompt")
        commandpromptstatusicon?.isTemplate = true
        commandpromptItem.image = commandpromptstatusicon
        
        readPropertyList()
        updateMenu()
        
        // Insert code here to initialize your application
    }
    
    // Quit app
    @IBAction func quitClicked(_ sender: NSMenuItem) {
        NSApplication.shared.terminate(self)
    }
    
    // Show notifications
    @IBAction func enableNotifications(_ sender: Any) {
        notificationsEnabled.state = notificationsEnabled.state == .on ? .off : .on
        savePropertyList()
    }
    
    
    @IBAction func enableOutputWindow(_ sender: Any) {
        outputWindowEnabled.state = outputWindowEnabled.state == .on ? .off : .on
        savePropertyList()
    }
    
    
    // Import settings
    
    @IBAction func importSettings(_ sender: Any) {
        let importAlert = NSAlert()
        importAlert.messageText = "Are you sure?"
        importAlert.informativeText = "This will overwrite your current settings"
        importAlert.alertStyle = .warning
        importAlert.addButton(withTitle: "OK")
        importAlert.addButton(withTitle: "Cancel")
        let shallWeImport = importAlert.runModal()
        if shallWeImport == NSApplication.ModalResponse.alertFirstButtonReturn {
            let dialog = NSOpenPanel()
            dialog.title = "Select a .plist file"
            dialog.allowsMultipleSelection = false
            dialog.showsResizeIndicator = true
            dialog.allowedFileTypes = ["plist"]
            if (dialog.runModal() == NSApplication.ModalResponse.OK) {
                let result = dialog.url
                if (result != nil) {
                    path = result!.path
                    NSLog(path)
                    let fileManager = FileManager.default
                    var propertyListFormat =  PropertyListSerialization.PropertyListFormat.xml
                    documentDirectory = NSSearchPathForDirectoriesInDomains(.applicationSupportDirectory, .userDomainMask, true)[0] as String
                    if (!fileManager.fileExists(atPath: path)) {
                        NSLog("Settings file does not exists. Creating blank one.")
                        savePropertyList()
                    }
                    let plistXML = FileManager.default.contents(atPath: path)!
                    do {
                        plistData = try PropertyListSerialization.propertyList(from: plistXML, options: .mutableContainersAndLeaves, format: &propertyListFormat) as! [String:AnyObject]
                    } catch {
                        print("Error reading plist: \(error), format: \(propertyListFormat)")
                    }
                    convertPlist()
                }
            }
            else {
                NSLog("User cancelled")
            }
        }
    }
    
    // Export settings
    
    @IBAction func exportSettings(_ sender: Any) {
        NSLog("export settings")
        let dialog = NSSavePanel()
        dialog.title = "Select a folder to save .plist file"
        dialog.allowedFileTypes = ["plist"]
        dialog.showsResizeIndicator = true
        dialog.allowsOtherFileTypes = false
        if (dialog.runModal() == NSApplication.ModalResponse.OK) {
            let result = dialog.url
            if (result != nil) {
                path = result!.path
                saveToPlist()
            }
        }
        else {
            NSLog("User cancelled")
        }
    }
    
    // Show preferences
    @IBAction func showPreferences(_ sender: Any) {
        self.preferencesWindow.orderFrontRegardless()
    }
    
    @IBAction func showResults(_ sender: Any) {
        self.resultsWindow.makeKeyAndOrderFront((Any).self)
    }
    
    
    @IBOutlet weak var notificationsEnabled: NSMenuItem!
    @IBOutlet weak var outputWindowEnabled: NSMenuItem!
    
    // Buttons
    @IBOutlet weak var savePref: NSButton!
    @IBOutlet weak var cancelPref: NSButton!
    
    // Checkboxes
    @IBOutlet weak var checkbox1: NSButton!
    @IBOutlet weak var checkbox2: NSButton!
    @IBOutlet weak var checkbox3: NSButton!
    @IBOutlet weak var checkbox4: NSButton!
    @IBOutlet weak var checkbox5: NSButton!
    @IBOutlet weak var checkbox6: NSButton!
    @IBOutlet weak var checkbox7: NSButton!
    @IBOutlet weak var checkbox8: NSButton!
    @IBOutlet weak var checkbox9: NSButton!
    @IBOutlet weak var checkbox10: NSButton!
  
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
    
    @IBOutlet weak var m_lab2: NSMenuItem!
    @IBOutlet weak var m_lab2_0: NSMenuItem!
    @IBOutlet weak var m_lab2_1: NSMenuItem!
    @IBOutlet weak var m_lab2_2: NSMenuItem!
    @IBOutlet weak var m_lab2_3: NSMenuItem!
    @IBOutlet weak var m_lab2_4: NSMenuItem!
    @IBOutlet weak var m_lab2_5: NSMenuItem!
    @IBOutlet weak var m_lab2_6: NSMenuItem!
    @IBOutlet weak var m_lab2_7: NSMenuItem!
    @IBOutlet weak var m_lab2_8: NSMenuItem!
    @IBOutlet weak var m_lab2_9: NSMenuItem!
    @IBOutlet weak var m_lab2_10: NSMenuItem!
    
    @IBOutlet weak var m_lab3: NSMenuItem!
    @IBOutlet weak var m_lab3_0: NSMenuItem!
    @IBOutlet weak var m_lab3_1: NSMenuItem!
    @IBOutlet weak var m_lab3_2: NSMenuItem!
    @IBOutlet weak var m_lab3_3: NSMenuItem!
    @IBOutlet weak var m_lab3_4: NSMenuItem!
    @IBOutlet weak var m_lab3_5: NSMenuItem!
    @IBOutlet weak var m_lab3_6: NSMenuItem!
    @IBOutlet weak var m_lab3_7: NSMenuItem!
    @IBOutlet weak var m_lab3_8: NSMenuItem!
    @IBOutlet weak var m_lab3_9: NSMenuItem!
    @IBOutlet weak var m_lab3_10: NSMenuItem!
    
    @IBOutlet weak var m_lab4: NSMenuItem!
    @IBOutlet weak var m_lab4_0: NSMenuItem!
    @IBOutlet weak var m_lab4_1: NSMenuItem!
    @IBOutlet weak var m_lab4_2: NSMenuItem!
    @IBOutlet weak var m_lab4_3: NSMenuItem!
    @IBOutlet weak var m_lab4_4: NSMenuItem!
    @IBOutlet weak var m_lab4_5: NSMenuItem!
    @IBOutlet weak var m_lab4_6: NSMenuItem!
    @IBOutlet weak var m_lab4_7: NSMenuItem!
    @IBOutlet weak var m_lab4_8: NSMenuItem!
    @IBOutlet weak var m_lab4_9: NSMenuItem!
    @IBOutlet weak var m_lab4_10: NSMenuItem!
    
    @IBOutlet weak var m_lab5: NSMenuItem!
    @IBOutlet weak var m_lab5_0: NSMenuItem!
    @IBOutlet weak var m_lab5_1: NSMenuItem!
    @IBOutlet weak var m_lab5_2: NSMenuItem!
    @IBOutlet weak var m_lab5_3: NSMenuItem!
    @IBOutlet weak var m_lab5_4: NSMenuItem!
    @IBOutlet weak var m_lab5_5: NSMenuItem!
    @IBOutlet weak var m_lab5_6: NSMenuItem!
    @IBOutlet weak var m_lab5_7: NSMenuItem!
    @IBOutlet weak var m_lab5_8: NSMenuItem!
    @IBOutlet weak var m_lab5_9: NSMenuItem!
    @IBOutlet weak var m_lab5_10: NSMenuItem!
    
    @IBOutlet weak var m_lab6: NSMenuItem!
    @IBOutlet weak var m_lab6_0: NSMenuItem!
    @IBOutlet weak var m_lab6_1: NSMenuItem!
    @IBOutlet weak var m_lab6_2: NSMenuItem!
    @IBOutlet weak var m_lab6_3: NSMenuItem!
    @IBOutlet weak var m_lab6_4: NSMenuItem!
    @IBOutlet weak var m_lab6_5: NSMenuItem!
    @IBOutlet weak var m_lab6_6: NSMenuItem!
    @IBOutlet weak var m_lab6_7: NSMenuItem!
    @IBOutlet weak var m_lab6_8: NSMenuItem!
    @IBOutlet weak var m_lab6_9: NSMenuItem!
    @IBOutlet weak var m_lab6_10: NSMenuItem!
    
    @IBOutlet weak var m_lab7: NSMenuItem!
    @IBOutlet weak var m_lab7_0: NSMenuItem!
    @IBOutlet weak var m_lab7_1: NSMenuItem!
    @IBOutlet weak var m_lab7_2: NSMenuItem!
    @IBOutlet weak var m_lab7_3: NSMenuItem!
    @IBOutlet weak var m_lab7_4: NSMenuItem!
    @IBOutlet weak var m_lab7_5: NSMenuItem!
    @IBOutlet weak var m_lab7_6: NSMenuItem!
    @IBOutlet weak var m_lab7_7: NSMenuItem!
    @IBOutlet weak var m_lab7_8: NSMenuItem!
    @IBOutlet weak var m_lab7_9: NSMenuItem!
    @IBOutlet weak var m_lab7_10: NSMenuItem!
    
    @IBOutlet weak var m_lab8: NSMenuItem!
    @IBOutlet weak var m_lab8_0: NSMenuItem!
    @IBOutlet weak var m_lab8_1: NSMenuItem!
    @IBOutlet weak var m_lab8_2: NSMenuItem!
    @IBOutlet weak var m_lab8_3: NSMenuItem!
    @IBOutlet weak var m_lab8_4: NSMenuItem!
    @IBOutlet weak var m_lab8_5: NSMenuItem!
    @IBOutlet weak var m_lab8_6: NSMenuItem!
    @IBOutlet weak var m_lab8_7: NSMenuItem!
    @IBOutlet weak var m_lab8_8: NSMenuItem!
    @IBOutlet weak var m_lab8_9: NSMenuItem!
    @IBOutlet weak var m_lab8_10: NSMenuItem!
    
    @IBOutlet weak var m_lab9: NSMenuItem!
    @IBOutlet weak var m_lab9_0: NSMenuItem!
    @IBOutlet weak var m_lab9_1: NSMenuItem!
    @IBOutlet weak var m_lab9_2: NSMenuItem!
    @IBOutlet weak var m_lab9_3: NSMenuItem!
    @IBOutlet weak var m_lab9_4: NSMenuItem!
    @IBOutlet weak var m_lab9_5: NSMenuItem!
    @IBOutlet weak var m_lab9_6: NSMenuItem!
    @IBOutlet weak var m_lab9_7: NSMenuItem!
    @IBOutlet weak var m_lab9_8: NSMenuItem!
    @IBOutlet weak var m_lab9_9: NSMenuItem!
    @IBOutlet weak var m_lab9_10: NSMenuItem!

    @IBOutlet weak var m_lab10: NSMenuItem!
    @IBOutlet weak var m_lab10_0: NSMenuItem!
    @IBOutlet weak var m_lab10_1: NSMenuItem!
    @IBOutlet weak var m_lab10_2: NSMenuItem!
    @IBOutlet weak var m_lab10_3: NSMenuItem!
    @IBOutlet weak var m_lab10_4: NSMenuItem!
    @IBOutlet weak var m_lab10_5: NSMenuItem!
    @IBOutlet weak var m_lab10_6: NSMenuItem!
    @IBOutlet weak var m_lab10_7: NSMenuItem!
    @IBOutlet weak var m_lab10_8: NSMenuItem!
    @IBOutlet weak var m_lab10_9: NSMenuItem!
    @IBOutlet weak var m_lab10_10: NSMenuItem!

    // Tabs
    @IBOutlet weak var menu1tab: NSTabViewItem!
    @IBOutlet weak var menu2tab: NSTabViewItem!
    @IBOutlet weak var menu3tab: NSTabViewItem!
    @IBOutlet weak var menu4tab: NSTabViewItem!
    @IBOutlet weak var menu5tab: NSTabViewItem!
    @IBOutlet weak var menu6tab: NSTabViewItem!
    @IBOutlet weak var menu7tab: NSTabViewItem!
    @IBOutlet weak var menu8tab: NSTabViewItem!
    @IBOutlet weak var menu9tab: NSTabViewItem!
    @IBOutlet weak var menu10tab: NSTabViewItem!
    
    // Labels
    @IBOutlet weak var Label1_1: NSTextField!
    @IBOutlet weak var Command1_0: NSTextField!
    @IBOutlet weak var Command1_1: NSTextField!
    
    @IBOutlet weak var Label2_1: NSTextField!
    @IBOutlet weak var Command2_0: NSTextField!
    @IBOutlet weak var Command2_1: NSTextField!
    
    @IBOutlet weak var Label3_1: NSTextField!
    @IBOutlet weak var Command3_0: NSTextField!
    @IBOutlet weak var Command3_1: NSTextField!
    
    @IBOutlet weak var Label4_1: NSTextField!
    @IBOutlet weak var Command4_0: NSTextField!
    @IBOutlet weak var Command4_1: NSTextField!
    
    @IBOutlet weak var Label5_1: NSTextField!
    @IBOutlet weak var Command5_0: NSTextField!
    @IBOutlet weak var Command5_1: NSTextField!
    
    @IBOutlet weak var Label6_1: NSTextField!
    @IBOutlet weak var Command6_0: NSTextField!
    @IBOutlet weak var Command6_1: NSTextField!
    
    @IBOutlet weak var Label7_1: NSTextField!
    @IBOutlet weak var Command7_0: NSTextField!
    @IBOutlet weak var Command7_1: NSTextField!
    
    @IBOutlet weak var Label8_1: NSTextField!
    @IBOutlet weak var Command8_0: NSTextField!
    @IBOutlet weak var Command8_1: NSTextField!
    
    @IBOutlet weak var Label9_1: NSTextField!
    @IBOutlet weak var Command9_0: NSTextField!
    @IBOutlet weak var Command9_1: NSTextField!
    
    @IBOutlet weak var Label10_1: NSTextField!
    @IBOutlet weak var Command10_0: NSTextField!
    @IBOutlet weak var Command10_1: NSTextField!
    
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
    
    @IBOutlet weak var p_lab2_0: NSTextField!
    @IBOutlet weak var p_lab2_1: NSTextField!
    @IBOutlet weak var p_lab2_2: NSTextField!
    @IBOutlet weak var p_lab2_3: NSTextField!
    @IBOutlet weak var p_lab2_4: NSTextField!
    @IBOutlet weak var p_lab2_5: NSTextField!
    @IBOutlet weak var p_lab2_6: NSTextField!
    @IBOutlet weak var p_lab2_7: NSTextField!
    @IBOutlet weak var p_lab2_8: NSTextField!
    @IBOutlet weak var p_lab2_9: NSTextField!
    @IBOutlet weak var p_lab2_10: NSTextField!
    
    @IBOutlet weak var p_lab3_0: NSTextField!
    @IBOutlet weak var p_lab3_1: NSTextField!
    @IBOutlet weak var p_lab3_2: NSTextField!
    @IBOutlet weak var p_lab3_3: NSTextField!
    @IBOutlet weak var p_lab3_4: NSTextField!
    @IBOutlet weak var p_lab3_5: NSTextField!
    @IBOutlet weak var p_lab3_6: NSTextField!
    @IBOutlet weak var p_lab3_7: NSTextField!
    @IBOutlet weak var p_lab3_8: NSTextField!
    @IBOutlet weak var p_lab3_9: NSTextField!
    @IBOutlet weak var p_lab3_10: NSTextField!
    
    @IBOutlet weak var p_lab4_0: NSTextField!
    @IBOutlet weak var p_lab4_1: NSTextField!
    @IBOutlet weak var p_lab4_2: NSTextField!
    @IBOutlet weak var p_lab4_3: NSTextField!
    @IBOutlet weak var p_lab4_4: NSTextField!
    @IBOutlet weak var p_lab4_5: NSTextField!
    @IBOutlet weak var p_lab4_6: NSTextField!
    @IBOutlet weak var p_lab4_7: NSTextField!
    @IBOutlet weak var p_lab4_8: NSTextField!
    @IBOutlet weak var p_lab4_9: NSTextField!
    @IBOutlet weak var p_lab4_10: NSTextField!
    
    @IBOutlet weak var p_lab5_0: NSTextField!
    @IBOutlet weak var p_lab5_1: NSTextField!
    @IBOutlet weak var p_lab5_2: NSTextField!
    @IBOutlet weak var p_lab5_3: NSTextField!
    @IBOutlet weak var p_lab5_4: NSTextField!
    @IBOutlet weak var p_lab5_5: NSTextField!
    @IBOutlet weak var p_lab5_6: NSTextField!
    @IBOutlet weak var p_lab5_7: NSTextField!
    @IBOutlet weak var p_lab5_8: NSTextField!
    @IBOutlet weak var p_lab5_9: NSTextField!
    @IBOutlet weak var p_lab5_10: NSTextField!

    @IBOutlet weak var p_lab6_0: NSTextField!
    @IBOutlet weak var p_lab6_1: NSTextField!
    @IBOutlet weak var p_lab6_2: NSTextField!
    @IBOutlet weak var p_lab6_3: NSTextField!
    @IBOutlet weak var p_lab6_4: NSTextField!
    @IBOutlet weak var p_lab6_5: NSTextField!
    @IBOutlet weak var p_lab6_6: NSTextField!
    @IBOutlet weak var p_lab6_7: NSTextField!
    @IBOutlet weak var p_lab6_8: NSTextField!
    @IBOutlet weak var p_lab6_9: NSTextField!
    @IBOutlet weak var p_lab6_10: NSTextField!

    @IBOutlet weak var p_lab7_0: NSTextField!
    @IBOutlet weak var p_lab7_1: NSTextField!
    @IBOutlet weak var p_lab7_2: NSTextField!
    @IBOutlet weak var p_lab7_3: NSTextField!
    @IBOutlet weak var p_lab7_4: NSTextField!
    @IBOutlet weak var p_lab7_5: NSTextField!
    @IBOutlet weak var p_lab7_6: NSTextField!
    @IBOutlet weak var p_lab7_7: NSTextField!
    @IBOutlet weak var p_lab7_8: NSTextField!
    @IBOutlet weak var p_lab7_9: NSTextField!
    @IBOutlet weak var p_lab7_10: NSTextField!
    
    @IBOutlet weak var p_lab8_0: NSTextField!
    @IBOutlet weak var p_lab8_1: NSTextField!
    @IBOutlet weak var p_lab8_2: NSTextField!
    @IBOutlet weak var p_lab8_3: NSTextField!
    @IBOutlet weak var p_lab8_4: NSTextField!
    @IBOutlet weak var p_lab8_5: NSTextField!
    @IBOutlet weak var p_lab8_6: NSTextField!
    @IBOutlet weak var p_lab8_7: NSTextField!
    @IBOutlet weak var p_lab8_8: NSTextField!
    @IBOutlet weak var p_lab8_9: NSTextField!
    @IBOutlet weak var p_lab8_10: NSTextField!
    
    @IBOutlet weak var p_lab9_0: NSTextField!
    @IBOutlet weak var p_lab9_1: NSTextField!
    @IBOutlet weak var p_lab9_2: NSTextField!
    @IBOutlet weak var p_lab9_3: NSTextField!
    @IBOutlet weak var p_lab9_4: NSTextField!
    @IBOutlet weak var p_lab9_5: NSTextField!
    @IBOutlet weak var p_lab9_6: NSTextField!
    @IBOutlet weak var p_lab9_7: NSTextField!
    @IBOutlet weak var p_lab9_8: NSTextField!
    @IBOutlet weak var p_lab9_9: NSTextField!
    @IBOutlet weak var p_lab9_10: NSTextField!
    
    @IBOutlet weak var p_lab10_0: NSTextField!
    @IBOutlet weak var p_lab10_1: NSTextField!
    @IBOutlet weak var p_lab10_2: NSTextField!
    @IBOutlet weak var p_lab10_3: NSTextField!
    @IBOutlet weak var p_lab10_4: NSTextField!
    @IBOutlet weak var p_lab10_5: NSTextField!
    @IBOutlet weak var p_lab10_6: NSTextField!
    @IBOutlet weak var p_lab10_7: NSTextField!
    @IBOutlet weak var p_lab10_8: NSTextField!
    @IBOutlet weak var p_lab10_9: NSTextField!
    @IBOutlet weak var p_lab10_10: NSTextField!
    
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
    
    @IBOutlet weak var p_cmd2_0: NSTextField!
    @IBOutlet weak var p_cmd2_1: NSTextField!
    @IBOutlet weak var p_cmd2_2: NSTextField!
    @IBOutlet weak var p_cmd2_3: NSTextField!
    @IBOutlet weak var p_cmd2_4: NSTextField!
    @IBOutlet weak var p_cmd2_5: NSTextField!
    @IBOutlet weak var p_cmd2_6: NSTextField!
    @IBOutlet weak var p_cmd2_7: NSTextField!
    @IBOutlet weak var p_cmd2_8: NSTextField!
    @IBOutlet weak var p_cmd2_9: NSTextField!
    @IBOutlet weak var p_cmd2_10: NSTextField!
    
    @IBOutlet weak var p_cmd3_0: NSTextField!
    @IBOutlet weak var p_cmd3_1: NSTextField!
    @IBOutlet weak var p_cmd3_2: NSTextField!
    @IBOutlet weak var p_cmd3_3: NSTextField!
    @IBOutlet weak var p_cmd3_4: NSTextField!
    @IBOutlet weak var p_cmd3_5: NSTextField!
    @IBOutlet weak var p_cmd3_6: NSTextField!
    @IBOutlet weak var p_cmd3_7: NSTextField!
    @IBOutlet weak var p_cmd3_8: NSTextField!
    @IBOutlet weak var p_cmd3_9: NSTextField!
    @IBOutlet weak var p_cmd3_10: NSTextField!
    
    @IBOutlet weak var p_cmd4_0: NSTextField!
    @IBOutlet weak var p_cmd4_1: NSTextField!
    @IBOutlet weak var p_cmd4_2: NSTextField!
    @IBOutlet weak var p_cmd4_3: NSTextField!
    @IBOutlet weak var p_cmd4_4: NSTextField!
    @IBOutlet weak var p_cmd4_5: NSTextField!
    @IBOutlet weak var p_cmd4_6: NSTextField!
    @IBOutlet weak var p_cmd4_7: NSTextField!
    @IBOutlet weak var p_cmd4_8: NSTextField!
    @IBOutlet weak var p_cmd4_9: NSTextField!
    @IBOutlet weak var p_cmd4_10: NSTextField!
    
    @IBOutlet weak var p_cmd5_0: NSTextField!
    @IBOutlet weak var p_cmd5_1: NSTextField!
    @IBOutlet weak var p_cmd5_2: NSTextField!
    @IBOutlet weak var p_cmd5_3: NSTextField!
    @IBOutlet weak var p_cmd5_4: NSTextField!
    @IBOutlet weak var p_cmd5_5: NSTextField!
    @IBOutlet weak var p_cmd5_6: NSTextField!
    @IBOutlet weak var p_cmd5_7: NSTextField!
    @IBOutlet weak var p_cmd5_8: NSTextField!
    @IBOutlet weak var p_cmd5_9: NSTextField!
    @IBOutlet weak var p_cmd5_10: NSTextField!
    
    @IBOutlet weak var p_cmd6_0: NSTextField!
    @IBOutlet weak var p_cmd6_1: NSTextField!
    @IBOutlet weak var p_cmd6_2: NSTextField!
    @IBOutlet weak var p_cmd6_3: NSTextField!
    @IBOutlet weak var p_cmd6_4: NSTextField!
    @IBOutlet weak var p_cmd6_5: NSTextField!
    @IBOutlet weak var p_cmd6_6: NSTextField!
    @IBOutlet weak var p_cmd6_7: NSTextField!
    @IBOutlet weak var p_cmd6_8: NSTextField!
    @IBOutlet weak var p_cmd6_9: NSTextField!
    @IBOutlet weak var p_cmd6_10: NSTextField!
    
    @IBOutlet weak var p_cmd7_0: NSTextField!
    @IBOutlet weak var p_cmd7_1: NSTextField!
    @IBOutlet weak var p_cmd7_2: NSTextField!
    @IBOutlet weak var p_cmd7_3: NSTextField!
    @IBOutlet weak var p_cmd7_4: NSTextField!
    @IBOutlet weak var p_cmd7_5: NSTextField!
    @IBOutlet weak var p_cmd7_6: NSTextField!
    @IBOutlet weak var p_cmd7_7: NSTextField!
    @IBOutlet weak var p_cmd7_8: NSTextField!
    @IBOutlet weak var p_cmd7_9: NSTextField!
    @IBOutlet weak var p_cmd7_10: NSTextField!
    
    @IBOutlet weak var p_cmd8_0: NSTextField!
    @IBOutlet weak var p_cmd8_1: NSTextField!
    @IBOutlet weak var p_cmd8_2: NSTextField!
    @IBOutlet weak var p_cmd8_3: NSTextField!
    @IBOutlet weak var p_cmd8_4: NSTextField!
    @IBOutlet weak var p_cmd8_5: NSTextField!
    @IBOutlet weak var p_cmd8_6: NSTextField!
    @IBOutlet weak var p_cmd8_7: NSTextField!
    @IBOutlet weak var p_cmd8_8: NSTextField!
    @IBOutlet weak var p_cmd8_9: NSTextField!
    @IBOutlet weak var p_cmd8_10: NSTextField!
    
    @IBOutlet weak var p_cmd9_0: NSTextField!
    @IBOutlet weak var p_cmd9_1: NSTextField!
    @IBOutlet weak var p_cmd9_2: NSTextField!
    @IBOutlet weak var p_cmd9_3: NSTextField!
    @IBOutlet weak var p_cmd9_4: NSTextField!
    @IBOutlet weak var p_cmd9_5: NSTextField!
    @IBOutlet weak var p_cmd9_6: NSTextField!
    @IBOutlet weak var p_cmd9_7: NSTextField!
    @IBOutlet weak var p_cmd9_8: NSTextField!
    @IBOutlet weak var p_cmd9_9: NSTextField!
    @IBOutlet weak var p_cmd9_10: NSTextField!
    
    @IBOutlet weak var p_cmd10_0: NSTextField!
    @IBOutlet weak var p_cmd10_1: NSTextField!
    @IBOutlet weak var p_cmd10_2: NSTextField!
    @IBOutlet weak var p_cmd10_3: NSTextField!
    @IBOutlet weak var p_cmd10_4: NSTextField!
    @IBOutlet weak var p_cmd10_5: NSTextField!
    @IBOutlet weak var p_cmd10_6: NSTextField!
    @IBOutlet weak var p_cmd10_7: NSTextField!
    @IBOutlet weak var p_cmd10_8: NSTextField!
    @IBOutlet weak var p_cmd10_9: NSTextField!
    @IBOutlet weak var p_cmd10_10: NSTextField!
    
    @IBAction func savePreferences(_ sender: Any) {
        updateMenu()
        savePropertyList()
        self.preferencesWindow.orderOut(self)
    }
    
    @IBAction func closeResults(_ sender: Any) {
        self.resultsWindow.orderOut(self)
    }
    
    
    // Update menu and label from plist
    func readPropertyList() {
        let fileManager = FileManager.default
        var propertyListFormat =  PropertyListSerialization.PropertyListFormat.xml
        documentDirectory = NSSearchPathForDirectoriesInDomains(.applicationSupportDirectory, .userDomainMask, true)[0] as String
        path = documentDirectory.appending("/com.tbrek.BashBar.plist")
        if (!fileManager.fileExists(atPath: path)) {
            NSLog("Settings file does not exists. Creating blank one.")
            savePropertyList()
        }
        let plistXML = FileManager.default.contents(atPath: path)!
        do {//convert the data to a dictionary and handle errors.
            plistData = try PropertyListSerialization.propertyList(from: plistXML, options: .mutableContainersAndLeaves, format: &propertyListFormat) as! [String:AnyObject]
            
        } catch {
            print("Error reading plist: \(error), format: \(propertyListFormat)")
        }
        convertPlist()
    }
    
    
    func convertPlist() {
        // Update label
        checkbox1.state  = (plistData["checkbox1"] as! Bool) == true ? .on : .off
        checkbox2.state  = (plistData["checkbox2"] as! Bool) == true ? .on : .off
        checkbox3.state  = (plistData["checkbox3"] as! Bool) == true ? .on : .off
        checkbox4.state  = (plistData["checkbox4"] as! Bool) == true ? .on : .off
        checkbox5.state  = (plistData["checkbox5"] as! Bool) == true ? .on : .off
        checkbox6.state  = (plistData["checkbox6"] as! Bool) == true ? .on : .off
        checkbox7.state  = (plistData["checkbox7"] as! Bool) == true ? .on : .off
        checkbox8.state  = (plistData["checkbox8"] as! Bool) == true ? .on : .off
        checkbox9.state  = (plistData["checkbox9"] as! Bool) == true ? .on : .off
        checkbox10.state  = (plistData["checkbox10"] as! Bool) == true ? .on : .off
        
        // Update notification status
        if (plistData["notificationsEnabled"] != nil) {
            notificationsEnabled.state = (plistData["notificationsEnabled"] as! Bool) == true ? .on : .off
        }
        if (plistData["outputWindowEnabled"] != nil) {
            outputWindowEnabled.state = (plistData["outputWindowEnabled"] as! Bool) == true ? .on : .off
        }
            
        
        self.checkbox( 0 )
        
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
        
        p_lab2_0.stringValue = plistData["p_lab2_0"] as! String
        p_cmd2_0.stringValue = plistData["p_cmd2_0"] as! String
        p_lab2_1.stringValue = plistData["p_lab2_1"] as! String
        p_cmd2_1.stringValue = plistData["p_cmd2_1"] as! String
        p_lab2_2.stringValue = plistData["p_lab2_2"] as! String
        p_cmd2_2.stringValue = plistData["p_cmd2_2"] as! String
        p_lab2_3.stringValue = plistData["p_lab2_3"] as! String
        p_cmd2_3.stringValue = plistData["p_cmd2_3"] as! String
        p_lab2_4.stringValue = plistData["p_lab2_4"] as! String
        p_cmd2_4.stringValue = plistData["p_cmd2_4"] as! String
        p_lab2_5.stringValue = plistData["p_lab2_5"] as! String
        p_cmd2_5.stringValue = plistData["p_cmd2_5"] as! String
        p_lab2_6.stringValue = plistData["p_lab2_6"] as! String
        p_cmd2_6.stringValue = plistData["p_cmd2_6"] as! String
        p_lab2_7.stringValue = plistData["p_lab2_7"] as! String
        p_cmd2_7.stringValue = plistData["p_cmd2_7"] as! String
        p_lab2_8.stringValue = plistData["p_lab2_8"] as! String
        p_cmd2_8.stringValue = plistData["p_cmd2_8"] as! String
        p_lab2_9.stringValue = plistData["p_lab2_9"] as! String
        p_cmd2_9.stringValue = plistData["p_cmd2_9"] as! String
        p_lab2_10.stringValue = plistData["p_lab2_10"] as! String
        p_cmd2_10.stringValue = plistData["p_cmd2_10"] as! String
        
        p_lab3_0.stringValue = plistData["p_lab3_0"] as! String
        p_cmd3_0.stringValue = plistData["p_cmd3_0"] as! String
        p_lab3_1.stringValue = plistData["p_lab3_1"] as! String
        p_cmd3_1.stringValue = plistData["p_cmd3_1"] as! String
        p_lab3_2.stringValue = plistData["p_lab3_2"] as! String
        p_cmd3_2.stringValue = plistData["p_cmd3_2"] as! String
        p_lab3_3.stringValue = plistData["p_lab3_3"] as! String
        p_cmd3_3.stringValue = plistData["p_cmd3_3"] as! String
        p_lab3_4.stringValue = plistData["p_lab3_4"] as! String
        p_cmd3_4.stringValue = plistData["p_cmd3_4"] as! String
        p_lab3_5.stringValue = plistData["p_lab3_5"] as! String
        p_cmd3_5.stringValue = plistData["p_cmd3_5"] as! String
        p_lab3_6.stringValue = plistData["p_lab3_6"] as! String
        p_cmd3_6.stringValue = plistData["p_cmd3_6"] as! String
        p_lab3_7.stringValue = plistData["p_lab3_7"] as! String
        p_cmd3_7.stringValue = plistData["p_cmd3_7"] as! String
        p_lab3_8.stringValue = plistData["p_lab3_8"] as! String
        p_cmd3_8.stringValue = plistData["p_cmd3_8"] as! String
        p_lab3_9.stringValue = plistData["p_lab3_9"] as! String
        p_cmd3_9.stringValue = plistData["p_cmd3_9"] as! String
        p_lab3_10.stringValue = plistData["p_lab3_10"] as! String
        p_cmd3_10.stringValue = plistData["p_cmd3_10"] as! String
        
        p_lab4_0.stringValue = plistData["p_lab4_0"] as! String
        p_cmd4_0.stringValue = plistData["p_cmd4_0"] as! String
        p_lab4_1.stringValue = plistData["p_lab4_1"] as! String
        p_cmd4_1.stringValue = plistData["p_cmd4_1"] as! String
        p_lab4_2.stringValue = plistData["p_lab4_2"] as! String
        p_cmd4_2.stringValue = plistData["p_cmd4_2"] as! String
        p_lab4_3.stringValue = plistData["p_lab4_3"] as! String
        p_cmd4_3.stringValue = plistData["p_cmd4_3"] as! String
        p_lab4_4.stringValue = plistData["p_lab4_4"] as! String
        p_cmd4_4.stringValue = plistData["p_cmd4_4"] as! String
        p_lab4_5.stringValue = plistData["p_lab4_5"] as! String
        p_cmd4_5.stringValue = plistData["p_cmd4_5"] as! String
        p_lab4_6.stringValue = plistData["p_lab4_6"] as! String
        p_cmd4_6.stringValue = plistData["p_cmd4_6"] as! String
        p_lab4_7.stringValue = plistData["p_lab4_7"] as! String
        p_cmd4_7.stringValue = plistData["p_cmd4_7"] as! String
        p_lab4_8.stringValue = plistData["p_lab4_8"] as! String
        p_cmd4_8.stringValue = plistData["p_cmd4_8"] as! String
        p_lab4_9.stringValue = plistData["p_lab4_9"] as! String
        p_cmd4_9.stringValue = plistData["p_cmd4_9"] as! String
        p_lab4_10.stringValue = plistData["p_lab4_10"] as! String
        p_cmd4_10.stringValue = plistData["p_cmd4_10"] as! String
        
        p_lab5_0.stringValue = plistData["p_lab5_0"] as! String
        p_cmd5_0.stringValue = plistData["p_cmd5_0"] as! String
        p_lab5_1.stringValue = plistData["p_lab5_1"] as! String
        p_cmd5_1.stringValue = plistData["p_cmd5_1"] as! String
        p_lab5_2.stringValue = plistData["p_lab5_2"] as! String
        p_cmd5_2.stringValue = plistData["p_cmd5_2"] as! String
        p_lab5_3.stringValue = plistData["p_lab5_3"] as! String
        p_cmd5_3.stringValue = plistData["p_cmd5_3"] as! String
        p_lab5_4.stringValue = plistData["p_lab5_4"] as! String
        p_cmd5_4.stringValue = plistData["p_cmd5_4"] as! String
        p_lab5_5.stringValue = plistData["p_lab5_5"] as! String
        p_cmd5_5.stringValue = plistData["p_cmd5_5"] as! String
        p_lab5_6.stringValue = plistData["p_lab5_6"] as! String
        p_cmd5_6.stringValue = plistData["p_cmd5_6"] as! String
        p_lab5_7.stringValue = plistData["p_lab5_7"] as! String
        p_cmd5_7.stringValue = plistData["p_cmd5_7"] as! String
        p_lab5_8.stringValue = plistData["p_lab5_8"] as! String
        p_cmd5_8.stringValue = plistData["p_cmd5_8"] as! String
        p_lab5_9.stringValue = plistData["p_lab5_9"] as! String
        p_cmd5_9.stringValue = plistData["p_cmd5_9"] as! String
        p_lab5_10.stringValue = plistData["p_lab5_10"] as! String
        p_cmd5_10.stringValue = plistData["p_cmd5_10"] as! String
        
        p_lab6_0.stringValue = plistData["p_lab6_0"] as! String
        p_cmd6_0.stringValue = plistData["p_cmd6_0"] as! String
        p_lab6_1.stringValue = plistData["p_lab6_1"] as! String
        p_cmd6_1.stringValue = plistData["p_cmd6_1"] as! String
        p_lab6_2.stringValue = plistData["p_lab6_2"] as! String
        p_cmd6_2.stringValue = plistData["p_cmd6_2"] as! String
        p_lab6_3.stringValue = plistData["p_lab6_3"] as! String
        p_cmd6_3.stringValue = plistData["p_cmd6_3"] as! String
        p_lab6_4.stringValue = plistData["p_lab6_4"] as! String
        p_cmd6_4.stringValue = plistData["p_cmd6_4"] as! String
        p_lab6_5.stringValue = plistData["p_lab6_5"] as! String
        p_cmd6_5.stringValue = plistData["p_cmd6_5"] as! String
        p_lab6_6.stringValue = plistData["p_lab6_6"] as! String
        p_cmd6_6.stringValue = plistData["p_cmd6_6"] as! String
        p_lab6_7.stringValue = plistData["p_lab6_7"] as! String
        p_cmd6_7.stringValue = plistData["p_cmd6_7"] as! String
        p_lab6_8.stringValue = plistData["p_lab6_8"] as! String
        p_cmd6_8.stringValue = plistData["p_cmd6_8"] as! String
        p_lab6_9.stringValue = plistData["p_lab6_9"] as! String
        p_cmd6_9.stringValue = plistData["p_cmd6_9"] as! String
        p_lab6_10.stringValue = plistData["p_lab6_10"] as! String
        p_cmd6_10.stringValue = plistData["p_cmd6_10"] as! String
        
        p_lab7_0.stringValue = plistData["p_lab7_0"] as! String
        p_cmd7_0.stringValue = plistData["p_cmd7_0"] as! String
        p_lab7_1.stringValue = plistData["p_lab7_1"] as! String
        p_cmd7_1.stringValue = plistData["p_cmd7_1"] as! String
        p_lab7_2.stringValue = plistData["p_lab7_2"] as! String
        p_cmd7_2.stringValue = plistData["p_cmd7_2"] as! String
        p_lab7_3.stringValue = plistData["p_lab7_3"] as! String
        p_cmd7_3.stringValue = plistData["p_cmd7_3"] as! String
        p_lab7_4.stringValue = plistData["p_lab7_4"] as! String
        p_cmd7_4.stringValue = plistData["p_cmd7_4"] as! String
        p_lab7_5.stringValue = plistData["p_lab7_5"] as! String
        p_cmd7_5.stringValue = plistData["p_cmd7_5"] as! String
        p_lab7_6.stringValue = plistData["p_lab7_6"] as! String
        p_cmd7_6.stringValue = plistData["p_cmd7_6"] as! String
        p_lab7_7.stringValue = plistData["p_lab7_7"] as! String
        p_cmd7_7.stringValue = plistData["p_cmd7_7"] as! String
        p_lab7_8.stringValue = plistData["p_lab7_8"] as! String
        p_cmd7_8.stringValue = plistData["p_cmd7_8"] as! String
        p_lab7_9.stringValue = plistData["p_lab7_9"] as! String
        p_cmd7_9.stringValue = plistData["p_cmd7_9"] as! String
        p_lab7_10.stringValue = plistData["p_lab7_10"] as! String
        p_cmd7_10.stringValue = plistData["p_cmd7_10"] as! String
        
        p_lab8_0.stringValue = plistData["p_lab8_0"] as! String
        p_cmd8_0.stringValue = plistData["p_cmd8_0"] as! String
        p_lab8_1.stringValue = plistData["p_lab8_1"] as! String
        p_cmd8_1.stringValue = plistData["p_cmd8_1"] as! String
        p_lab8_2.stringValue = plistData["p_lab8_2"] as! String
        p_cmd8_2.stringValue = plistData["p_cmd8_2"] as! String
        p_lab8_3.stringValue = plistData["p_lab8_3"] as! String
        p_cmd8_3.stringValue = plistData["p_cmd8_3"] as! String
        p_lab8_4.stringValue = plistData["p_lab8_4"] as! String
        p_cmd8_4.stringValue = plistData["p_cmd8_4"] as! String
        p_lab8_5.stringValue = plistData["p_lab8_5"] as! String
        p_cmd8_5.stringValue = plistData["p_cmd8_5"] as! String
        p_lab8_6.stringValue = plistData["p_lab8_6"] as! String
        p_cmd8_6.stringValue = plistData["p_cmd8_6"] as! String
        p_lab8_7.stringValue = plistData["p_lab8_7"] as! String
        p_cmd8_7.stringValue = plistData["p_cmd8_7"] as! String
        p_lab8_8.stringValue = plistData["p_lab8_8"] as! String
        p_cmd8_8.stringValue = plistData["p_cmd8_8"] as! String
        p_lab8_9.stringValue = plistData["p_lab8_9"] as! String
        p_cmd8_9.stringValue = plistData["p_cmd8_9"] as! String
        p_lab8_10.stringValue = plistData["p_lab8_10"] as! String
        p_cmd8_10.stringValue = plistData["p_cmd8_10"] as! String
        
        p_lab9_0.stringValue = plistData["p_lab9_0"] as! String
        p_cmd9_0.stringValue = plistData["p_cmd9_0"] as! String
        p_lab9_1.stringValue = plistData["p_lab9_1"] as! String
        p_cmd9_1.stringValue = plistData["p_cmd9_1"] as! String
        p_lab9_2.stringValue = plistData["p_lab9_2"] as! String
        p_cmd9_2.stringValue = plistData["p_cmd9_2"] as! String
        p_lab9_3.stringValue = plistData["p_lab9_3"] as! String
        p_cmd9_3.stringValue = plistData["p_cmd9_3"] as! String
        p_lab9_4.stringValue = plistData["p_lab9_4"] as! String
        p_cmd9_4.stringValue = plistData["p_cmd9_4"] as! String
        p_lab9_5.stringValue = plistData["p_lab9_5"] as! String
        p_cmd9_5.stringValue = plistData["p_cmd9_5"] as! String
        p_lab9_6.stringValue = plistData["p_lab9_6"] as! String
        p_cmd9_6.stringValue = plistData["p_cmd9_6"] as! String
        p_lab9_7.stringValue = plistData["p_lab9_7"] as! String
        p_cmd9_7.stringValue = plistData["p_cmd9_7"] as! String
        p_lab9_8.stringValue = plistData["p_lab9_8"] as! String
        p_cmd9_8.stringValue = plistData["p_cmd9_8"] as! String
        p_lab9_9.stringValue = plistData["p_lab9_9"] as! String
        p_cmd9_9.stringValue = plistData["p_cmd9_9"] as! String
        p_lab9_10.stringValue = plistData["p_lab9_10"] as! String
        p_cmd9_10.stringValue = plistData["p_cmd9_10"] as! String
        
        p_lab10_0.stringValue = plistData["p_lab10_0"] as! String
        p_cmd10_0.stringValue = plistData["p_cmd10_0"] as! String
        p_lab10_1.stringValue = plistData["p_lab10_1"] as! String
        p_cmd10_1.stringValue = plistData["p_cmd10_1"] as! String
        p_lab10_2.stringValue = plistData["p_lab10_2"] as! String
        p_cmd10_2.stringValue = plistData["p_cmd10_2"] as! String
        p_lab10_3.stringValue = plistData["p_lab10_3"] as! String
        p_cmd10_3.stringValue = plistData["p_cmd10_3"] as! String
        p_lab10_4.stringValue = plistData["p_lab10_4"] as! String
        p_cmd10_4.stringValue = plistData["p_cmd10_4"] as! String
        p_lab10_5.stringValue = plistData["p_lab10_5"] as! String
        p_cmd10_5.stringValue = plistData["p_cmd10_5"] as! String
        p_lab10_6.stringValue = plistData["p_lab10_6"] as! String
        p_cmd10_6.stringValue = plistData["p_cmd10_6"] as! String
        p_lab10_7.stringValue = plistData["p_lab10_7"] as! String
        p_cmd10_7.stringValue = plistData["p_cmd10_7"] as! String
        p_lab10_8.stringValue = plistData["p_lab10_8"] as! String
        p_cmd10_8.stringValue = plistData["p_cmd10_8"] as! String
        p_lab10_9.stringValue = plistData["p_lab10_9"] as! String
        p_cmd10_9.stringValue = plistData["p_cmd10_9"] as! String
        p_lab10_10.stringValue = plistData["p_lab10_10"] as! String
        p_cmd10_10.stringValue = plistData["p_cmd10_10"] as! String
        
        updateMenu()
    }
    
    func savePropertyList() {
        documentDirectory = NSSearchPathForDirectoriesInDomains(.applicationSupportDirectory, .userDomainMask, true)[0] as String
        path = documentDirectory.appending("/com.tbrek.BashBar.plist")
        saveToPlist()
    }
    
        
    func saveToPlist() {
        let dicContent = [
            "notificationsEnabled": notificationsEnabled.state,
            "outputWindowEnabled": outputWindowEnabled.state,
            
            "checkbox1": checkbox1.state,
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
            "p_cmd1_10": p_cmd1_10.stringValue ,
            
            "checkbox2": checkbox2.state,
            "p_lab2_0": p_lab2_0.stringValue ,
            "p_cmd2_0": p_cmd2_0.stringValue ,
            "p_lab2_1": p_lab2_1.stringValue ,
            "p_cmd2_1": p_cmd2_1.stringValue ,
            "p_lab2_2": p_lab2_2.stringValue ,
            "p_cmd2_2": p_cmd2_2.stringValue ,
            "p_lab2_3": p_lab2_3.stringValue ,
            "p_cmd2_3": p_cmd2_3.stringValue ,
            "p_lab2_4": p_lab2_4.stringValue ,
            "p_cmd2_4": p_cmd2_4.stringValue ,
            "p_lab2_5": p_lab2_5.stringValue ,
            "p_cmd2_5": p_cmd2_5.stringValue ,
            "p_lab2_6": p_lab2_6.stringValue ,
            "p_cmd2_6": p_cmd2_6.stringValue ,
            "p_lab2_7": p_lab2_7.stringValue ,
            "p_cmd2_7": p_cmd2_7.stringValue ,
            "p_lab2_8": p_lab2_8.stringValue ,
            "p_cmd2_8": p_cmd2_8.stringValue ,
            "p_lab2_9": p_lab2_9.stringValue ,
            "p_cmd2_9": p_cmd2_9.stringValue ,
            "p_lab2_10": p_lab2_10.stringValue ,
            "p_cmd2_10": p_cmd2_10.stringValue ,
            
            "checkbox3": checkbox3.state,
            "p_lab3_0": p_lab3_0.stringValue ,
            "p_cmd3_0": p_cmd3_0.stringValue ,
            "p_lab3_1": p_lab3_1.stringValue ,
            "p_cmd3_1": p_cmd3_1.stringValue ,
            "p_lab3_2": p_lab3_2.stringValue ,
            "p_cmd3_2": p_cmd3_2.stringValue ,
            "p_lab3_3": p_lab3_3.stringValue ,
            "p_cmd3_3": p_cmd3_3.stringValue ,
            "p_lab3_4": p_lab3_4.stringValue ,
            "p_cmd3_4": p_cmd3_4.stringValue ,
            "p_lab3_5": p_lab3_5.stringValue ,
            "p_cmd3_5": p_cmd3_5.stringValue ,
            "p_lab3_6": p_lab3_6.stringValue ,
            "p_cmd3_6": p_cmd3_6.stringValue ,
            "p_lab3_7": p_lab3_7.stringValue ,
            "p_cmd3_7": p_cmd3_7.stringValue ,
            "p_lab3_8": p_lab3_8.stringValue ,
            "p_cmd3_8": p_cmd3_8.stringValue ,
            "p_lab3_9": p_lab3_9.stringValue ,
            "p_cmd3_9": p_cmd3_9.stringValue ,
            "p_lab3_10": p_lab3_10.stringValue ,
            "p_cmd3_10": p_cmd3_10.stringValue ,
            
            "checkbox4": checkbox4.state,
            "p_lab4_0": p_lab4_0.stringValue ,
            "p_cmd4_0": p_cmd4_0.stringValue ,
            "p_lab4_1": p_lab4_1.stringValue ,
            "p_cmd4_1": p_cmd4_1.stringValue ,
            "p_lab4_2": p_lab4_2.stringValue ,
            "p_cmd4_2": p_cmd4_2.stringValue ,
            "p_lab4_3": p_lab4_3.stringValue ,
            "p_cmd4_3": p_cmd4_3.stringValue ,
            "p_lab4_4": p_lab4_4.stringValue ,
            "p_cmd4_4": p_cmd4_4.stringValue ,
            "p_lab4_5": p_lab4_5.stringValue ,
            "p_cmd4_5": p_cmd4_5.stringValue ,
            "p_lab4_6": p_lab4_6.stringValue ,
            "p_cmd4_6": p_cmd4_6.stringValue ,
            "p_lab4_7": p_lab4_7.stringValue ,
            "p_cmd4_7": p_cmd4_7.stringValue ,
            "p_lab4_8": p_lab4_8.stringValue ,
            "p_cmd4_8": p_cmd4_8.stringValue ,
            "p_lab4_9": p_lab4_9.stringValue ,
            "p_cmd4_9": p_cmd4_9.stringValue ,
            "p_lab4_10": p_lab4_10.stringValue ,
            "p_cmd4_10": p_cmd4_10.stringValue ,
            
            "checkbox5": checkbox5.state,
            "p_lab5_0": p_lab5_0.stringValue ,
            "p_cmd5_0": p_cmd5_0.stringValue ,
            "p_lab5_1": p_lab5_1.stringValue ,
            "p_cmd5_1": p_cmd5_1.stringValue ,
            "p_lab5_2": p_lab5_2.stringValue ,
            "p_cmd5_2": p_cmd5_2.stringValue ,
            "p_lab5_3": p_lab5_3.stringValue ,
            "p_cmd5_3": p_cmd5_3.stringValue ,
            "p_lab5_4": p_lab5_4.stringValue ,
            "p_cmd5_4": p_cmd5_4.stringValue ,
            "p_lab5_5": p_lab5_5.stringValue ,
            "p_cmd5_5": p_cmd5_5.stringValue ,
            "p_lab5_6": p_lab5_6.stringValue ,
            "p_cmd5_6": p_cmd5_6.stringValue ,
            "p_lab5_7": p_lab5_7.stringValue ,
            "p_cmd5_7": p_cmd5_7.stringValue ,
            "p_lab5_8": p_lab5_8.stringValue ,
            "p_cmd5_8": p_cmd5_8.stringValue ,
            "p_lab5_9": p_lab5_9.stringValue ,
            "p_cmd5_9": p_cmd5_9.stringValue ,
            "p_lab5_10": p_lab5_10.stringValue ,
            "p_cmd5_10": p_cmd5_10.stringValue ,
            
            "checkbox6": checkbox6.state,
            "p_lab6_0": p_lab6_0.stringValue ,
            "p_cmd6_0": p_cmd6_0.stringValue ,
            "p_lab6_1": p_lab6_1.stringValue ,
            "p_cmd6_1": p_cmd6_1.stringValue ,
            "p_lab6_2": p_lab6_2.stringValue ,
            "p_cmd6_2": p_cmd6_2.stringValue ,
            "p_lab6_3": p_lab6_3.stringValue ,
            "p_cmd6_3": p_cmd6_3.stringValue ,
            "p_lab6_4": p_lab6_4.stringValue ,
            "p_cmd6_4": p_cmd6_4.stringValue ,
            "p_lab6_5": p_lab6_5.stringValue ,
            "p_cmd6_5": p_cmd6_5.stringValue ,
            "p_lab6_6": p_lab6_6.stringValue ,
            "p_cmd6_6": p_cmd6_6.stringValue ,
            "p_lab6_7": p_lab6_7.stringValue ,
            "p_cmd6_7": p_cmd6_7.stringValue ,
            "p_lab6_8": p_lab6_8.stringValue ,
            "p_cmd6_8": p_cmd6_8.stringValue ,
            "p_lab6_9": p_lab6_9.stringValue ,
            "p_cmd6_9": p_cmd6_9.stringValue ,
            "p_lab6_10": p_lab6_10.stringValue ,
            "p_cmd6_10": p_cmd6_10.stringValue ,
            
            "checkbox7": checkbox7.state,
            "p_lab7_0": p_lab7_0.stringValue ,
            "p_cmd7_0": p_cmd7_0.stringValue ,
            "p_lab7_1": p_lab7_1.stringValue ,
            "p_cmd7_1": p_cmd7_1.stringValue ,
            "p_lab7_2": p_lab7_2.stringValue ,
            "p_cmd7_2": p_cmd7_2.stringValue ,
            "p_lab7_3": p_lab7_3.stringValue ,
            "p_cmd7_3": p_cmd7_3.stringValue ,
            "p_lab7_4": p_lab7_4.stringValue ,
            "p_cmd7_4": p_cmd7_4.stringValue ,
            "p_lab7_5": p_lab7_5.stringValue ,
            "p_cmd7_5": p_cmd7_5.stringValue ,
            "p_lab7_6": p_lab7_6.stringValue ,
            "p_cmd7_6": p_cmd7_6.stringValue ,
            "p_lab7_7": p_lab7_7.stringValue ,
            "p_cmd7_7": p_cmd7_7.stringValue ,
            "p_lab7_8": p_lab7_8.stringValue ,
            "p_cmd7_8": p_cmd7_8.stringValue ,
            "p_lab7_9": p_lab7_9.stringValue ,
            "p_cmd7_9": p_cmd7_9.stringValue ,
            "p_lab7_10": p_lab7_10.stringValue ,
            "p_cmd7_10": p_cmd7_10.stringValue ,
            
            "checkbox8": checkbox8.state,
            "p_lab8_0": p_lab8_0.stringValue ,
            "p_cmd8_0": p_cmd8_0.stringValue ,
            "p_lab8_1": p_lab8_1.stringValue ,
            "p_cmd8_1": p_cmd8_1.stringValue ,
            "p_lab8_2": p_lab8_2.stringValue ,
            "p_cmd8_2": p_cmd8_2.stringValue ,
            "p_lab8_3": p_lab8_3.stringValue ,
            "p_cmd8_3": p_cmd8_3.stringValue ,
            "p_lab8_4": p_lab8_4.stringValue ,
            "p_cmd8_4": p_cmd8_4.stringValue ,
            "p_lab8_5": p_lab8_5.stringValue ,
            "p_cmd8_5": p_cmd8_5.stringValue ,
            "p_lab8_6": p_lab8_6.stringValue ,
            "p_cmd8_6": p_cmd8_6.stringValue ,
            "p_lab8_7": p_lab8_7.stringValue ,
            "p_cmd8_7": p_cmd8_7.stringValue ,
            "p_lab8_8": p_lab8_8.stringValue ,
            "p_cmd8_8": p_cmd8_8.stringValue ,
            "p_lab8_9": p_lab8_9.stringValue ,
            "p_cmd8_9": p_cmd8_9.stringValue ,
            "p_lab8_10": p_lab8_10.stringValue ,
            "p_cmd8_10": p_cmd8_10.stringValue ,
            
            "checkbox9": checkbox9.state,
            "p_lab9_0": p_lab9_0.stringValue ,
            "p_cmd9_0": p_cmd9_0.stringValue ,
            "p_lab9_1": p_lab9_1.stringValue ,
            "p_cmd9_1": p_cmd9_1.stringValue ,
            "p_lab9_2": p_lab9_2.stringValue ,
            "p_cmd9_2": p_cmd9_2.stringValue ,
            "p_lab9_3": p_lab9_3.stringValue ,
            "p_cmd9_3": p_cmd9_3.stringValue ,
            "p_lab9_4": p_lab9_4.stringValue ,
            "p_cmd9_4": p_cmd9_4.stringValue ,
            "p_lab9_5": p_lab9_5.stringValue ,
            "p_cmd9_5": p_cmd9_5.stringValue ,
            "p_lab9_6": p_lab9_6.stringValue ,
            "p_cmd9_6": p_cmd9_6.stringValue ,
            "p_lab9_7": p_lab9_7.stringValue ,
            "p_cmd9_7": p_cmd9_7.stringValue ,
            "p_lab9_8": p_lab9_8.stringValue ,
            "p_cmd9_8": p_cmd9_8.stringValue ,
            "p_lab9_9": p_lab9_9.stringValue ,
            "p_cmd9_9": p_cmd9_9.stringValue ,
            "p_lab9_10": p_lab9_10.stringValue ,
            "p_cmd9_10": p_cmd9_10.stringValue ,
            
            "checkbox10": checkbox10.state,
            "p_lab10_0": p_lab10_0.stringValue ,
            "p_cmd10_0": p_cmd10_0.stringValue ,
            "p_lab10_1": p_lab10_1.stringValue ,
            "p_cmd10_1": p_cmd10_1.stringValue ,
            "p_lab10_2": p_lab10_2.stringValue ,
            "p_cmd10_2": p_cmd10_2.stringValue ,
            "p_lab10_3": p_lab10_3.stringValue ,
            "p_cmd10_3": p_cmd10_3.stringValue ,
            "p_lab10_4": p_lab10_4.stringValue ,
            "p_cmd10_4": p_cmd10_4.stringValue ,
            "p_lab10_5": p_lab10_5.stringValue ,
            "p_cmd10_5": p_cmd10_5.stringValue ,
            "p_lab10_6": p_lab10_6.stringValue ,
            "p_cmd10_6": p_cmd10_6.stringValue ,
            "p_lab10_7": p_lab10_7.stringValue ,
            "p_cmd10_7": p_cmd10_7.stringValue ,
            "p_lab10_8": p_lab10_8.stringValue ,
            "p_cmd10_8": p_cmd10_8.stringValue ,
            "p_lab10_9": p_lab10_9.stringValue ,
            "p_cmd10_9": p_cmd10_9.stringValue ,
            "p_lab10_10": p_lab10_10.stringValue ,
            "p_cmd10_10": p_cmd10_10.stringValue
                        ] as [String : Any]
       
        let plistData = NSDictionary(dictionary: dicContent)
        let success:Bool = plistData.write(toFile: path, atomically: true)
        if success {

        }
            else
          {
            
          }
    }
    
    
    @IBAction func checkbox(_ sender: Any) {
    
        // Update Menu
        m_lab1_0.isHidden = checkbox1.state == .on ? false : true
        m_lab1.isHidden    = checkbox1.state == .on ? true : false
        
        m_lab2_0.isHidden = checkbox2.state == .on ? false : true
        m_lab2.isHidden    = checkbox2.state == .on ? true : false
        
        m_lab3_0.isHidden = checkbox3.state == .on ? false : true
        m_lab3.isHidden    = checkbox3.state == .on ? true : false
        
        m_lab4_0.isHidden = checkbox4.state == .on ? false : true
        m_lab4.isHidden    = checkbox4.state == .on ? true : false
        
        m_lab5_0.isHidden = checkbox5.state == .on ? false : true
        m_lab5.isHidden    = checkbox5.state == .on ? true : false
        
        m_lab6_0.isHidden = checkbox6.state == .on ? false : true
        m_lab6.isHidden    = checkbox6.state == .on ? true : false
        
        m_lab7_0.isHidden = checkbox7.state == .on ? false : true
        m_lab7.isHidden    = checkbox7.state == .on ? true : false
        
        m_lab8_0.isHidden = checkbox8.state == .on ? false : true
        m_lab8.isHidden    = checkbox8.state == .on ? true : false
        
        m_lab9_0.isHidden = checkbox9.state == .on ? false : true
        m_lab9.isHidden    = checkbox9.state == .on ? true : false
        
        m_lab10_0.isHidden = checkbox10.state == .on ? false : true
        m_lab10.isHidden    = checkbox10.state == .on ? true : false
        
        // Hide/Show Labels
        Label1_1.isHidden = checkbox1.state == .on ? false : true
        Command1_0.isHidden = checkbox1.state == .on ? true : false
        Command1_1.isHidden = checkbox1.state == .on ? false : true
        
        Label2_1.isHidden = checkbox2.state == .on ? false : true
        Command2_0.isHidden = checkbox2.state == .on ? true : false
        Command2_1.isHidden = checkbox2.state == .on ? false : true
        
        Label3_1.isHidden = checkbox3.state == .on ? false : true
        Command3_0.isHidden = checkbox3.state == .on ? true : false
        Command3_1.isHidden = checkbox3.state == .on ? false : true
        
        Label4_1.isHidden = checkbox4.state == .on ? false : true
        Command4_0.isHidden = checkbox4.state == .on ? true : false
        Command4_1.isHidden = checkbox4.state == .on ? false : true
        
        Label5_1.isHidden = checkbox5.state == .on ? false : true
        Command5_0.isHidden = checkbox5.state == .on ? true : false
        Command5_1.isHidden = checkbox5.state == .on ? false : true
        
        Label6_1.isHidden = checkbox6.state == .on ? false : true
        Command6_0.isHidden = checkbox6.state == .on ? true : false
        Command6_1.isHidden = checkbox6.state == .on ? false : true
        
        Label7_1.isHidden = checkbox7.state == .on ? false : true
        Command7_0.isHidden = checkbox7.state == .on ? true : false
        Command7_1.isHidden = checkbox7.state == .on ? false : true
        
        Label8_1.isHidden = checkbox8.state == .on ? false : true
        Command8_0.isHidden = checkbox8.state == .on ? true : false
        Command8_1.isHidden = checkbox8.state == .on ? false : true
        
        Label9_1.isHidden = checkbox9.state == .on ? false : true
        Command9_0.isHidden = checkbox9.state == .on ? true : false
        Command9_1.isHidden = checkbox9.state == .on ? false : true
        
        Label10_1.isHidden = checkbox10.state == .on ? false : true
        Command10_0.isHidden = checkbox10.state == .on ? true : false
        Command10_1.isHidden = checkbox10.state == .on ? false : true
        
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
        
        p_cmd2_0.isHidden  = checkbox2.state == .on ? true : false
        p_lab2_1.isHidden  = checkbox2.state == .on ? false : true
        p_cmd2_1.isHidden  = checkbox2.state == .on ? false : true
        p_lab2_2.isHidden  = checkbox2.state == .on ? false : true
        p_cmd2_2.isHidden  = checkbox2.state == .on ? false : true
        p_lab2_3.isHidden  = checkbox2.state == .on ? false : true
        p_cmd2_3.isHidden  = checkbox2.state == .on ? false : true
        p_lab2_4.isHidden  = checkbox2.state == .on ? false : true
        p_cmd2_4.isHidden  = checkbox2.state == .on ? false : true
        p_lab2_5.isHidden  = checkbox2.state == .on ? false : true
        p_cmd2_5.isHidden  = checkbox2.state == .on ? false : true
        p_lab2_6.isHidden  = checkbox2.state == .on ? false : true
        p_cmd2_6.isHidden  = checkbox2.state == .on ? false : true
        p_lab2_7.isHidden  = checkbox2.state == .on ? false : true
        p_cmd2_7.isHidden  = checkbox2.state == .on ? false : true
        p_lab2_8.isHidden  = checkbox2.state == .on ? false : true
        p_cmd2_8.isHidden  = checkbox2.state == .on ? false : true
        p_lab2_9.isHidden  = checkbox2.state == .on ? false : true
        p_cmd2_9.isHidden  = checkbox2.state == .on ? false : true
        p_lab2_10.isHidden  = checkbox2.state == .on ? false : true
        p_cmd2_10.isHidden  = checkbox2.state == .on ? false : true
        
        p_cmd3_0.isHidden  = checkbox3.state == .on ? true : false
        p_lab3_1.isHidden  = checkbox3.state == .on ? false : true
        p_cmd3_1.isHidden  = checkbox3.state == .on ? false : true
        p_lab3_2.isHidden  = checkbox3.state == .on ? false : true
        p_cmd3_2.isHidden  = checkbox3.state == .on ? false : true
        p_lab3_3.isHidden  = checkbox3.state == .on ? false : true
        p_cmd3_3.isHidden  = checkbox3.state == .on ? false : true
        p_lab3_4.isHidden  = checkbox3.state == .on ? false : true
        p_cmd3_4.isHidden  = checkbox3.state == .on ? false : true
        p_lab3_5.isHidden  = checkbox3.state == .on ? false : true
        p_cmd3_5.isHidden  = checkbox3.state == .on ? false : true
        p_lab3_6.isHidden  = checkbox3.state == .on ? false : true
        p_cmd3_6.isHidden  = checkbox3.state == .on ? false : true
        p_lab3_7.isHidden  = checkbox3.state == .on ? false : true
        p_cmd3_7.isHidden  = checkbox3.state == .on ? false : true
        p_lab3_8.isHidden  = checkbox3.state == .on ? false : true
        p_cmd3_8.isHidden  = checkbox3.state == .on ? false : true
        p_lab3_9.isHidden  = checkbox3.state == .on ? false : true
        p_cmd3_9.isHidden  = checkbox3.state == .on ? false : true
        p_lab3_10.isHidden  = checkbox3.state == .on ? false : true
        p_cmd3_10.isHidden  = checkbox3.state == .on ? false : true
        
        p_cmd4_0.isHidden  = checkbox4.state == .on ? true : false
        p_lab4_1.isHidden  = checkbox4.state == .on ? false : true
        p_cmd4_1.isHidden  = checkbox4.state == .on ? false : true
        p_lab4_2.isHidden  = checkbox4.state == .on ? false : true
        p_cmd4_2.isHidden  = checkbox4.state == .on ? false : true
        p_lab4_3.isHidden  = checkbox4.state == .on ? false : true
        p_cmd4_3.isHidden  = checkbox4.state == .on ? false : true
        p_lab4_4.isHidden  = checkbox4.state == .on ? false : true
        p_cmd4_4.isHidden  = checkbox4.state == .on ? false : true
        p_lab4_5.isHidden  = checkbox4.state == .on ? false : true
        p_cmd4_5.isHidden  = checkbox4.state == .on ? false : true
        p_lab4_6.isHidden  = checkbox4.state == .on ? false : true
        p_cmd4_6.isHidden  = checkbox4.state == .on ? false : true
        p_lab4_7.isHidden  = checkbox4.state == .on ? false : true
        p_cmd4_7.isHidden  = checkbox4.state == .on ? false : true
        p_lab4_8.isHidden  = checkbox4.state == .on ? false : true
        p_cmd4_8.isHidden  = checkbox4.state == .on ? false : true
        p_lab4_9.isHidden  = checkbox4.state == .on ? false : true
        p_cmd4_9.isHidden  = checkbox4.state == .on ? false : true
        p_lab4_10.isHidden  = checkbox4.state == .on ? false : true
        p_cmd4_10.isHidden  = checkbox4.state == .on ? false : true
        
        p_cmd5_0.isHidden  = checkbox5.state == .on ? true : false
        p_lab5_1.isHidden  = checkbox5.state == .on ? false : true
        p_cmd5_1.isHidden  = checkbox5.state == .on ? false : true
        p_lab5_2.isHidden  = checkbox5.state == .on ? false : true
        p_cmd5_2.isHidden  = checkbox5.state == .on ? false : true
        p_lab5_3.isHidden  = checkbox5.state == .on ? false : true
        p_cmd5_3.isHidden  = checkbox5.state == .on ? false : true
        p_lab5_4.isHidden  = checkbox5.state == .on ? false : true
        p_cmd5_4.isHidden  = checkbox5.state == .on ? false : true
        p_lab5_5.isHidden  = checkbox5.state == .on ? false : true
        p_cmd5_5.isHidden  = checkbox5.state == .on ? false : true
        p_lab5_6.isHidden  = checkbox5.state == .on ? false : true
        p_cmd5_6.isHidden  = checkbox5.state == .on ? false : true
        p_lab5_7.isHidden  = checkbox5.state == .on ? false : true
        p_cmd5_7.isHidden  = checkbox5.state == .on ? false : true
        p_lab5_8.isHidden  = checkbox5.state == .on ? false : true
        p_cmd5_8.isHidden  = checkbox5.state == .on ? false : true
        p_lab5_9.isHidden  = checkbox5.state == .on ? false : true
        p_cmd5_9.isHidden  = checkbox5.state == .on ? false : true
        p_lab5_10.isHidden  = checkbox5.state == .on ? false : true
        p_cmd5_10.isHidden  = checkbox5.state == .on ? false : true
        
        p_cmd6_0.isHidden  = checkbox6.state == .on ? true : false
        p_lab6_1.isHidden  = checkbox6.state == .on ? false : true
        p_cmd6_1.isHidden  = checkbox6.state == .on ? false : true
        p_lab6_2.isHidden  = checkbox6.state == .on ? false : true
        p_cmd6_2.isHidden  = checkbox6.state == .on ? false : true
        p_lab6_3.isHidden  = checkbox6.state == .on ? false : true
        p_cmd6_3.isHidden  = checkbox6.state == .on ? false : true
        p_lab6_4.isHidden  = checkbox6.state == .on ? false : true
        p_cmd6_4.isHidden  = checkbox6.state == .on ? false : true
        p_lab6_5.isHidden  = checkbox6.state == .on ? false : true
        p_cmd6_5.isHidden  = checkbox6.state == .on ? false : true
        p_lab6_6.isHidden  = checkbox6.state == .on ? false : true
        p_cmd6_6.isHidden  = checkbox6.state == .on ? false : true
        p_lab6_7.isHidden  = checkbox6.state == .on ? false : true
        p_cmd6_7.isHidden  = checkbox6.state == .on ? false : true
        p_lab6_8.isHidden  = checkbox6.state == .on ? false : true
        p_cmd6_8.isHidden  = checkbox6.state == .on ? false : true
        p_lab6_9.isHidden  = checkbox6.state == .on ? false : true
        p_cmd6_9.isHidden  = checkbox6.state == .on ? false : true
        p_lab6_10.isHidden  = checkbox6.state == .on ? false : true
        p_cmd6_10.isHidden  = checkbox6.state == .on ? false : true
        
        p_cmd7_0.isHidden  = checkbox7.state == .on ? true : false
        p_lab7_1.isHidden  = checkbox7.state == .on ? false : true
        p_cmd7_1.isHidden  = checkbox7.state == .on ? false : true
        p_lab7_2.isHidden  = checkbox7.state == .on ? false : true
        p_cmd7_2.isHidden  = checkbox7.state == .on ? false : true
        p_lab7_3.isHidden  = checkbox7.state == .on ? false : true
        p_cmd7_3.isHidden  = checkbox7.state == .on ? false : true
        p_lab7_4.isHidden  = checkbox7.state == .on ? false : true
        p_cmd7_4.isHidden  = checkbox7.state == .on ? false : true
        p_lab7_5.isHidden  = checkbox7.state == .on ? false : true
        p_cmd7_5.isHidden  = checkbox7.state == .on ? false : true
        p_lab7_6.isHidden  = checkbox7.state == .on ? false : true
        p_cmd7_6.isHidden  = checkbox7.state == .on ? false : true
        p_lab7_7.isHidden  = checkbox7.state == .on ? false : true
        p_cmd7_7.isHidden  = checkbox7.state == .on ? false : true
        p_lab7_8.isHidden  = checkbox7.state == .on ? false : true
        p_cmd7_8.isHidden  = checkbox7.state == .on ? false : true
        p_lab7_9.isHidden  = checkbox7.state == .on ? false : true
        p_cmd7_9.isHidden  = checkbox7.state == .on ? false : true
        p_lab7_10.isHidden  = checkbox7.state == .on ? false : true
        p_cmd7_10.isHidden  = checkbox7.state == .on ? false : true
        
        p_cmd8_0.isHidden  = checkbox8.state == .on ? true : false
        p_lab8_1.isHidden  = checkbox8.state == .on ? false : true
        p_cmd8_1.isHidden  = checkbox8.state == .on ? false : true
        p_lab8_2.isHidden  = checkbox8.state == .on ? false : true
        p_cmd8_2.isHidden  = checkbox8.state == .on ? false : true
        p_lab8_3.isHidden  = checkbox8.state == .on ? false : true
        p_cmd8_3.isHidden  = checkbox8.state == .on ? false : true
        p_lab8_4.isHidden  = checkbox8.state == .on ? false : true
        p_cmd8_4.isHidden  = checkbox8.state == .on ? false : true
        p_lab8_5.isHidden  = checkbox8.state == .on ? false : true
        p_cmd8_5.isHidden  = checkbox8.state == .on ? false : true
        p_lab8_6.isHidden  = checkbox8.state == .on ? false : true
        p_cmd8_6.isHidden  = checkbox8.state == .on ? false : true
        p_lab8_7.isHidden  = checkbox8.state == .on ? false : true
        p_cmd8_7.isHidden  = checkbox8.state == .on ? false : true
        p_lab8_8.isHidden  = checkbox8.state == .on ? false : true
        p_cmd8_8.isHidden  = checkbox8.state == .on ? false : true
        p_lab8_9.isHidden  = checkbox8.state == .on ? false : true
        p_cmd8_9.isHidden  = checkbox8.state == .on ? false : true
        p_lab8_10.isHidden  = checkbox8.state == .on ? false : true
        p_cmd8_10.isHidden  = checkbox8.state == .on ? false : true
        
        p_cmd9_0.isHidden  = checkbox9.state == .on ? true : false
        p_lab9_1.isHidden  = checkbox9.state == .on ? false : true
        p_cmd9_1.isHidden  = checkbox9.state == .on ? false : true
        p_lab9_2.isHidden  = checkbox9.state == .on ? false : true
        p_cmd9_2.isHidden  = checkbox9.state == .on ? false : true
        p_lab9_3.isHidden  = checkbox9.state == .on ? false : true
        p_cmd9_3.isHidden  = checkbox9.state == .on ? false : true
        p_lab9_4.isHidden  = checkbox9.state == .on ? false : true
        p_cmd9_4.isHidden  = checkbox9.state == .on ? false : true
        p_lab9_5.isHidden  = checkbox9.state == .on ? false : true
        p_cmd9_5.isHidden  = checkbox9.state == .on ? false : true
        p_lab9_6.isHidden  = checkbox9.state == .on ? false : true
        p_cmd9_6.isHidden  = checkbox9.state == .on ? false : true
        p_lab9_7.isHidden  = checkbox9.state == .on ? false : true
        p_cmd9_7.isHidden  = checkbox9.state == .on ? false : true
        p_lab9_8.isHidden  = checkbox9.state == .on ? false : true
        p_cmd9_8.isHidden  = checkbox9.state == .on ? false : true
        p_lab9_9.isHidden  = checkbox9.state == .on ? false : true
        p_cmd9_9.isHidden  = checkbox9.state == .on ? false : true
        p_lab9_10.isHidden  = checkbox9.state == .on ? false : true
        p_cmd9_10.isHidden  = checkbox9.state == .on ? false : true
        
        p_cmd10_0.isHidden  = checkbox10.state == .on ? true : false
        p_lab10_1.isHidden  = checkbox10.state == .on ? false : true
        p_cmd10_1.isHidden  = checkbox10.state == .on ? false : true
        p_lab10_2.isHidden  = checkbox10.state == .on ? false : true
        p_cmd10_2.isHidden  = checkbox10.state == .on ? false : true
        p_lab10_3.isHidden  = checkbox10.state == .on ? false : true
        p_cmd10_3.isHidden  = checkbox10.state == .on ? false : true
        p_lab10_4.isHidden  = checkbox10.state == .on ? false : true
        p_cmd10_4.isHidden  = checkbox10.state == .on ? false : true
        p_lab10_5.isHidden  = checkbox10.state == .on ? false : true
        p_cmd10_5.isHidden  = checkbox10.state == .on ? false : true
        p_lab10_6.isHidden  = checkbox10.state == .on ? false : true
        p_cmd10_6.isHidden  = checkbox10.state == .on ? false : true
        p_lab10_7.isHidden  = checkbox10.state == .on ? false : true
        p_cmd10_7.isHidden  = checkbox10.state == .on ? false : true
        p_lab10_8.isHidden  = checkbox10.state == .on ? false : true
        p_cmd10_8.isHidden  = checkbox10.state == .on ? false : true
        p_lab10_9.isHidden  = checkbox10.state == .on ? false : true
        p_cmd10_9.isHidden  = checkbox10.state == .on ? false : true
        p_lab10_10.isHidden  = checkbox10.state == .on ? false : true
        p_cmd10_10.isHidden  = checkbox10.state == .on ? false : true
        
    }
    
    
    func updateMenu() {
        
        // Tab
        menu1tab.label = p_lab1_0.stringValue
        menu2tab.label = p_lab2_0.stringValue
        menu3tab.label = p_lab3_0.stringValue
        menu4tab.label = p_lab4_0.stringValue
        menu5tab.label = p_lab5_0.stringValue
        menu6tab.label = p_lab6_0.stringValue
        menu7tab.label = p_lab7_0.stringValue
        menu8tab.label = p_lab8_0.stringValue
        menu9tab.label = p_lab9_0.stringValue
        menu10tab.label = p_lab10_0.stringValue
        
        // Menus
		setup(menuItem: m_lab1, menuLabeltem: m_lab1_0, textField: p_lab1_0, cmdTextField: p_cmd1_0, checkBox: checkbox1)
		setup(menuItem: m_lab2, menuLabeltem: m_lab2_0, textField: p_lab2_0, cmdTextField: p_cmd2_0, checkBox: checkbox2)
		setup(menuItem: m_lab3, menuLabeltem: m_lab3_0, textField: p_lab3_0, cmdTextField: p_cmd3_0, checkBox: checkbox3)
		setup(menuItem: m_lab4, menuLabeltem: m_lab4_0, textField: p_lab4_0, cmdTextField: p_cmd4_0, checkBox: checkbox4)
		setup(menuItem: m_lab5, menuLabeltem: m_lab5_0, textField: p_lab5_0, cmdTextField: p_cmd5_0, checkBox: checkbox5)
		setup(menuItem: m_lab6, menuLabeltem: m_lab6_0, textField: p_lab6_0, cmdTextField: p_cmd6_0, checkBox: checkbox6)
		setup(menuItem: m_lab7, menuLabeltem: m_lab7_0, textField: p_lab7_0, cmdTextField: p_cmd7_0, checkBox: checkbox7)
		setup(menuItem: m_lab8, menuLabeltem: m_lab8_0, textField: p_lab8_0, cmdTextField: p_cmd8_0, checkBox: checkbox8)
		setup(menuItem: m_lab9, menuLabeltem: m_lab9_0, textField: p_lab9_0, cmdTextField: p_cmd9_0, checkBox: checkbox9)
		setup(menuItem: m_lab10, menuLabeltem: m_lab10_0, textField: p_lab10_0, cmdTextField: p_cmd10_0, checkBox: checkbox10)
      
        // Submenus
        setup(menuItem: m_lab1_1, nameField: p_lab1_1, commandField: p_cmd1_1)
        setup(menuItem: m_lab1_2, nameField: p_lab1_2, commandField: p_cmd1_2)
        setup(menuItem: m_lab1_3, nameField: p_lab1_3, commandField: p_cmd1_3)
        setup(menuItem: m_lab1_4, nameField: p_lab1_4, commandField: p_cmd1_4)
        setup(menuItem: m_lab1_5, nameField: p_lab1_5, commandField: p_cmd1_5)
        setup(menuItem: m_lab1_6, nameField: p_lab1_6, commandField: p_cmd1_6)
        setup(menuItem: m_lab1_7, nameField: p_lab1_7, commandField: p_cmd1_7)
        setup(menuItem: m_lab1_8, nameField: p_lab1_8, commandField: p_cmd1_8)
        setup(menuItem: m_lab1_9, nameField: p_lab1_9, commandField: p_cmd1_9)
        setup(menuItem: m_lab1_10, nameField: p_lab1_10, commandField: p_cmd1_10)
        
        setup(menuItem: m_lab2_1, nameField: p_lab2_1, commandField: p_cmd2_1)
        setup(menuItem: m_lab2_2, nameField: p_lab2_2, commandField: p_cmd2_2)
        setup(menuItem: m_lab2_3, nameField: p_lab2_3, commandField: p_cmd2_3)
        setup(menuItem: m_lab2_4, nameField: p_lab2_4, commandField: p_cmd2_4)
        setup(menuItem: m_lab2_5, nameField: p_lab2_5, commandField: p_cmd2_5)
        setup(menuItem: m_lab2_6, nameField: p_lab2_6, commandField: p_cmd2_6)
        setup(menuItem: m_lab2_7, nameField: p_lab2_7, commandField: p_cmd2_7)
        setup(menuItem: m_lab2_8, nameField: p_lab2_8, commandField: p_cmd2_8)
        setup(menuItem: m_lab2_9, nameField: p_lab2_9, commandField: p_cmd2_9)
        setup(menuItem: m_lab2_10, nameField: p_lab2_10, commandField: p_cmd2_10)
        
        setup(menuItem: m_lab3_1, nameField: p_lab3_1, commandField: p_cmd3_1)
        setup(menuItem: m_lab3_2, nameField: p_lab3_2, commandField: p_cmd3_2)
        setup(menuItem: m_lab3_3, nameField: p_lab3_3, commandField: p_cmd3_3)
        setup(menuItem: m_lab3_4, nameField: p_lab3_4, commandField: p_cmd3_4)
        setup(menuItem: m_lab3_5, nameField: p_lab3_5, commandField: p_cmd3_5)
        setup(menuItem: m_lab3_6, nameField: p_lab3_6, commandField: p_cmd3_6)
        setup(menuItem: m_lab3_7, nameField: p_lab3_7, commandField: p_cmd3_7)
        setup(menuItem: m_lab3_8, nameField: p_lab3_8, commandField: p_cmd3_8)
        setup(menuItem: m_lab3_9, nameField: p_lab3_9, commandField: p_cmd3_9)
        setup(menuItem: m_lab3_10, nameField: p_lab3_10, commandField: p_cmd3_10)
        
        setup(menuItem: m_lab4_1, nameField: p_lab4_1, commandField: p_cmd4_1)
        setup(menuItem: m_lab4_2, nameField: p_lab4_2, commandField: p_cmd4_2)
        setup(menuItem: m_lab4_3, nameField: p_lab4_3, commandField: p_cmd4_3)
        setup(menuItem: m_lab4_4, nameField: p_lab4_4, commandField: p_cmd4_4)
        setup(menuItem: m_lab4_5, nameField: p_lab4_5, commandField: p_cmd4_5)
        setup(menuItem: m_lab4_6, nameField: p_lab4_6, commandField: p_cmd4_6)
        setup(menuItem: m_lab4_7, nameField: p_lab4_7, commandField: p_cmd4_7)
        setup(menuItem: m_lab4_8, nameField: p_lab4_8, commandField: p_cmd4_8)
        setup(menuItem: m_lab4_9, nameField: p_lab4_9, commandField: p_cmd4_9)
        setup(menuItem: m_lab4_10, nameField: p_lab4_10, commandField: p_cmd4_10)
        
        setup(menuItem: m_lab5_1, nameField: p_lab5_1, commandField: p_cmd5_1)
        setup(menuItem: m_lab5_2, nameField: p_lab5_2, commandField: p_cmd5_2)
        setup(menuItem: m_lab5_3, nameField: p_lab5_3, commandField: p_cmd5_3)
        setup(menuItem: m_lab5_4, nameField: p_lab5_4, commandField: p_cmd5_4)
        setup(menuItem: m_lab5_5, nameField: p_lab5_5, commandField: p_cmd5_5)
        setup(menuItem: m_lab5_6, nameField: p_lab5_6, commandField: p_cmd5_6)
        setup(menuItem: m_lab5_7, nameField: p_lab5_7, commandField: p_cmd5_7)
        setup(menuItem: m_lab5_8, nameField: p_lab5_8, commandField: p_cmd5_8)
        setup(menuItem: m_lab5_9, nameField: p_lab5_9, commandField: p_cmd5_9)
        setup(menuItem: m_lab5_10, nameField: p_lab5_10, commandField: p_cmd5_10)
        
        setup(menuItem: m_lab6_1, nameField: p_lab6_1, commandField: p_cmd6_1)
        setup(menuItem: m_lab6_2, nameField: p_lab6_2, commandField: p_cmd6_2)
        setup(menuItem: m_lab6_3, nameField: p_lab6_3, commandField: p_cmd6_3)
        setup(menuItem: m_lab6_4, nameField: p_lab6_4, commandField: p_cmd6_4)
        setup(menuItem: m_lab6_5, nameField: p_lab6_5, commandField: p_cmd6_5)
        setup(menuItem: m_lab6_6, nameField: p_lab6_6, commandField: p_cmd6_6)
        setup(menuItem: m_lab6_7, nameField: p_lab6_7, commandField: p_cmd6_7)
        setup(menuItem: m_lab6_8, nameField: p_lab6_8, commandField: p_cmd6_8)
        setup(menuItem: m_lab6_9, nameField: p_lab6_9, commandField: p_cmd6_9)
        setup(menuItem: m_lab6_10, nameField: p_lab6_10, commandField: p_cmd6_10)
        
        setup(menuItem: m_lab7_1, nameField: p_lab7_1, commandField: p_cmd7_1)
        setup(menuItem: m_lab7_2, nameField: p_lab7_2, commandField: p_cmd7_2)
        setup(menuItem: m_lab7_3, nameField: p_lab7_3, commandField: p_cmd7_3)
        setup(menuItem: m_lab7_4, nameField: p_lab7_4, commandField: p_cmd7_4)
        setup(menuItem: m_lab7_5, nameField: p_lab7_5, commandField: p_cmd7_5)
        setup(menuItem: m_lab7_6, nameField: p_lab7_6, commandField: p_cmd7_6)
        setup(menuItem: m_lab7_7, nameField: p_lab7_7, commandField: p_cmd7_7)
        setup(menuItem: m_lab7_8, nameField: p_lab7_8, commandField: p_cmd7_8)
        setup(menuItem: m_lab7_9, nameField: p_lab7_9, commandField: p_cmd7_9)
        setup(menuItem: m_lab7_10, nameField: p_lab7_10, commandField: p_cmd7_10)
        
        setup(menuItem: m_lab8_1, nameField: p_lab8_1, commandField: p_cmd8_1)
        setup(menuItem: m_lab8_2, nameField: p_lab8_2, commandField: p_cmd8_2)
        setup(menuItem: m_lab8_3, nameField: p_lab8_3, commandField: p_cmd8_3)
        setup(menuItem: m_lab8_4, nameField: p_lab8_4, commandField: p_cmd8_4)
        setup(menuItem: m_lab8_5, nameField: p_lab8_5, commandField: p_cmd8_5)
        setup(menuItem: m_lab8_6, nameField: p_lab8_6, commandField: p_cmd8_6)
        setup(menuItem: m_lab8_7, nameField: p_lab8_7, commandField: p_cmd8_7)
        setup(menuItem: m_lab8_8, nameField: p_lab8_8, commandField: p_cmd8_8)
        setup(menuItem: m_lab8_9, nameField: p_lab8_9, commandField: p_cmd8_9)
        setup(menuItem: m_lab8_10, nameField: p_lab8_10, commandField: p_cmd8_10)
        
        setup(menuItem: m_lab9_1, nameField: p_lab9_1, commandField: p_cmd9_1)
        setup(menuItem: m_lab9_2, nameField: p_lab9_2, commandField: p_cmd9_2)
        setup(menuItem: m_lab9_3, nameField: p_lab9_3, commandField: p_cmd9_3)
        setup(menuItem: m_lab9_4, nameField: p_lab9_4, commandField: p_cmd9_4)
        setup(menuItem: m_lab9_5, nameField: p_lab9_5, commandField: p_cmd9_5)
        setup(menuItem: m_lab9_6, nameField: p_lab9_6, commandField: p_cmd9_6)
        setup(menuItem: m_lab9_7, nameField: p_lab9_7, commandField: p_cmd9_7)
        setup(menuItem: m_lab9_8, nameField: p_lab9_8, commandField: p_cmd9_8)
        setup(menuItem: m_lab9_9, nameField: p_lab9_9, commandField: p_cmd9_9)
        setup(menuItem: m_lab9_10, nameField: p_lab9_10, commandField: p_cmd9_10)
        
        setup(menuItem: m_lab10_1, nameField: p_lab10_1, commandField: p_cmd10_1)
        setup(menuItem: m_lab10_2, nameField: p_lab10_2, commandField: p_cmd10_2)
        setup(menuItem: m_lab10_3, nameField: p_lab10_3, commandField: p_cmd10_3)
        setup(menuItem: m_lab10_4, nameField: p_lab10_4, commandField: p_cmd10_4)
        setup(menuItem: m_lab10_5, nameField: p_lab10_5, commandField: p_cmd10_5)
        setup(menuItem: m_lab10_6, nameField: p_lab10_6, commandField: p_cmd10_6)
        setup(menuItem: m_lab10_7, nameField: p_lab10_7, commandField: p_cmd10_7)
        setup(menuItem: m_lab10_8, nameField: p_lab10_8, commandField: p_cmd10_8)
        setup(menuItem: m_lab10_9, nameField: p_lab10_9, commandField: p_cmd10_9)
        setup(menuItem: m_lab10_10, nameField: p_lab10_10, commandField: p_cmd10_10)
    }
	
	private func setup(menuItem: NSMenuItem, menuLabeltem: NSMenuItem, textField: NSTextField, cmdTextField: NSTextField, checkBox: NSButton) {
		menuItem.title      = textField.stringValue
		menuItem.toolTip    = cmdTextField.stringValue
		menuItem.isHidden   = (textField.stringValue == "" || checkBox.state == .on) ? true : false
		menuLabeltem.title    = textField.stringValue
		menuLabeltem.isHidden = (textField.stringValue == "" || checkBox.state == .off) ? true : false
	}
	
    private func setup(menuItem: NSMenuItem, nameField: NSTextField, commandField: NSTextField) {
        menuItem.title    = nameField.stringValue
        menuItem.toolTip  = commandField.stringValue
        menuItem.isHidden = nameField.stringValue == "" ? true : false
    }
    
    private func shell(_ arguments: String) {
        var args = arguments
        let nsString = args as NSString
        let range = NSRange(location: 0, length: args.count)
        let regex = try! NSRegularExpression(pattern: "%% .*? %%")
        let results = regex.matches(in: args, range: range)
        let variables = results.map { nsString.substring(with: $0.range)}
        var aborted = false
        
        // Iterate trough variables
        for variable in variables {
            let range = NSRange(location: 0, length: variable.count)
            var regex = try! NSRegularExpression(pattern: "(?<=<).*(?=>)")
            let nsString = variable as NSString
            var results = regex.matches(in: variable, range: range)
            let description = results.map { nsString.substring(with: $0.range)}
            regex = try! NSRegularExpression(pattern: "(?<=%% ).*(?= <)")
            results = regex.matches(in: variable, range: range)
            let variable_type = results.map { nsString.substring(with: $0.range)}
            var value = ""
            switch variable_type[0] {
            case "path":
                let dialog = NSOpenPanel()
                dialog.message = "Select file or directory"
                dialog.allowsMultipleSelection = false
                dialog.showsResizeIndicator = true
                dialog.canChooseDirectories = true
                if (dialog.runModal() == NSApplication.ModalResponse.OK) {
                    let result = dialog.url
                    if (result != nil) {
                        value = result!.path
                    }
                }
                else {
                    aborted = true
                    break
                }
            default:
                let msg = NSAlert()
                msg.addButton(withTitle: "OK")
                msg.addButton(withTitle: "Abort")
                msg.messageText = "Input variable"
                let inputTextField = NSTextField(frame: NSRect(x: 0, y: 0, width: 300, height: 24))
                inputTextField.placeholderString = description[0]
                msg.accessoryView = inputTextField
                let res = msg.runModal()
                if res == NSApplication.ModalResponse.alertSecondButtonReturn {
                    aborted = true
                    break
                    }
                value = inputTextField.stringValue
            }
            if aborted {
                aborted = false
                return
            }
            args = args.replacingOccurrences(of: variable, with: value as String)
        }
        
        var myAppleScript = "do shell script \""+args+"\""
        if args.range(of: "sudo") != nil {
            myAppleScript = myAppleScript + " with administrator privileges"
        }

        var error: NSDictionary?
        let scriptObject = NSAppleScript(source: myAppleScript)
        if let output: NSAppleEventDescriptor = scriptObject?.executeAndReturnError(
                &error) {
                errorMenu.title = "Success"
                resultsView.textColor = NSColor(red: 131/255, green: 148/255, blue: 150/255, alpha: 1)
                resultsView.font = NSFont(name: "Andale Mono", size: 12.0)
            if tailLogsCheckbox.state == .on {
                resultsView.string = resultsView.string + "\n" + output.stringValue!
            } else {
                resultsView.string = output.stringValue!
            }
                
            } else if (error != nil) {
                errorMenu.title = (error?.object(forKey: NSAppleScript.errorMessage) as! String)
            resultsView.textColor = NSColor(red: 131/255, green: 148/255, blue: 150/255, alpha: 1)
            resultsView.font = NSFont(name: "Andale Mono", size: 12.0)
            resultsView.string = (error?.object(forKey: NSAppleScript.errorMessage) as! String)
            }
            if notificationsEnabled.state == .on {
                showNotification(message: "\(args):\n\(errorMenu.title)",title: "Command prompt output for")
            }
        if outputWindowEnabled.state == .on {
            showResults(self)
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
    
    // Notifications
    func showNotification(message:String, title:String = "App Name") -> Void {
        let notification = NSUserNotification()
        notification.title = title
        notification.informativeText = message
        notification.hasReplyButton = false
        notification.hasActionButton = false
        NSUserNotificationCenter.default.deliver(notification)
    }
}
