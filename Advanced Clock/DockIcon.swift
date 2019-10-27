//
//  DockIcon.swift
//  Advanced Clock
//
//  Created by Riley Roach on 10/27/19.
//  Copyright © 2019 Riley Roach. All rights reserved.
//

import Foundation
import AppKit


struct DockIcon {
    static var standard = DockIcon()
    
    
    var isVisible: Bool {
        get {
            return NSApp.activationPolicy() == .regular
        }
        
        set {
            setVisibility(isVisible)
        }
    }
    
    
    @discardableResult
    func setVisibility(_ state: Bool) -> Bool {
        if state {
            NSApp.setActivationPolicy(.regular)
        } else {
            NSApp.setActivationPolicy(.accessory)
        }
        
        return isVisible
    }
}



