//
//  AppDelegate.swift
//  Advanced Clock
//
//  Created by Riley Roach on 10/27/19.
//  Copyright © 2019 Riley Roach. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    var statusBarItem: NSStatusItem = NSStatusBar.system.statusItem(
        withLength: NSStatusItem.variableLength
    )
    var timer: Timer? = nil
    
    
    func applicationWillFinishLaunching(_ notification: Notification) {
        if Preferences.firstRunGone == false {
            
            Preferences.firstRunGone = true
            
            Preferences.restore()
        }
        
        DockIcon.standard.setVisibility(Preferences.showDockIcon)
    }
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        guard let statusButton = statusBarItem.button else { return }
        
        
        statusButton.title = Preferences.showSeconds ?
            Date.now.stringTimeWithSeconds : Date.now.stringTime
        
        
        timer = Timer.scheduledTimer(
            timeInterval: 1,
            target: self,
            selector: #selector(updateStatusText),
            userInfo: nil,
            repeats: true
        )
        
        
        let statusMenu: NSMenu = NSMenu()
        
        statusMenu.addItem(
            withTitle: "Good \(Date.now.isMorning ? "Morning" : "Evening")",
            action: nil,
            keyEquivalent: ""
        )
        statusMenu.addSeparator()
        
        
        let toggleFlashingSeparatorsItem: NSMenuItem = {
            let item = NSMenuItem(
                title: "Flashing separators",
                action: #selector(toggleFlashingSeparators),
                keyEquivalent: ""
            )
            
            
            item.tag = 1
            item.target = self
            item.state = Preferences.useFlashDots.stateValue
            
            
            return item
        }()
        
        
        let toggleDockIconItem: NSMenuItem = {
            let item = NSMenuItem(
                title: "Toggle Dock Icon",
                action: #selector(toggleDockIcon),
                keyEquivalent: ""
            )
            
            
            item.tag = 2
            item.target = self
            item.state = Preferences.showDockIcon.stateValue
            
            return item
        }()
        
        
        let toggleSecondsItem: NSMenuItem = {
            let item = NSMenuItem(
                title: "Show Seconds",
                action: #selector(toggleSeconds),
                keyEquivalent: ""
            )
            
            item.tag = 3
            item.target = self
            item.state = Preferences.showSeconds.stateValue
            
            return item
        }()
        
        
        let quitApplicationItem: NSMenuItem = {
            let item = NSMenuItem(
                title: "Quit",
                action: #selector(terminate),
                keyEquivalent: "q"
            )
            item.target = self
            
            return item
        }()
        
        statusMenu.addItems(
            toggleFlashingSeparatorsItem,
            toggleDockIconItem,
            .separator(),
            toggleSecondsItem,
            .separator(),
            quitApplicationItem
        )
        
        statusBarItem.menu = statusMenu
    }

}



/*
 * ------------
 * MARK: - Actions
 * ------------
 */

extension AppDelegate {
    @objc
    func updateStatusText(_ sender: Timer) {
        guard let statusButton = statusBarItem.button else { return }
//        statusButton.title = Date.now.stringTimeWithSeconds
//        print(Date.now.stringTimeWithSeconds)
        var title: String = (
            Preferences.showSeconds ? Date.now.stringTimeWithSeconds :
                Date.now.stringTime
        )
        
        
        if Preferences.useFlashDots && Date.now.seconds % 2 == 0 {
            title = title.replacingOccurrences(of: ":", with: " ")
        }
        
        statusButton.title = title
    }
    
    @objc
    func toggleFlashingSeparators(_ sender: NSMenuItem) {
        Preferences.useFlashDots = !Preferences.useFlashDots
        
        
        if let menu = statusBarItem.menu, let item = menu.item(withTag: 1) {
            item.state = Preferences.useFlashDots.stateValue
        }
    }
    
    
    @objc
    func toggleDockIcon(_ sender: NSMenuItem) {
        Preferences.showDockIcon = !Preferences.showDockIcon
        
        
        DockIcon.standard.setVisibility(Preferences.showDockIcon)
        
        if let menu = statusBarItem.menu, let item = menu.item(withTag: 2) {
            item.state = Preferences.showDockIcon.stateValue
        }
    }
    
    
    @objc
    func toggleSeconds(_ sender: NSMenuItem) {
        Preferences.showSeconds = !Preferences.showSeconds
        
        if let menu = statusBarItem.menu, let item = menu.item(withTag: 3) {
            item.title = "Show seconds"
            item.state = Preferences.showSeconds.stateValue
        }
    }
    
    
    @objc
    func terminate(_ sender: NSMenuItem) {
        NSApp.terminate(sender)
    }
}
