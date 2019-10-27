//
//  NSMenu+Extension.swift
//  Advanced Clock
//
//  Created by Riley Roach on 10/27/19.
//  Copyright © 2019 Riley Roach. All rights reserved.
//

import Foundation
import AppKit


extension NSMenu {
    func addSeparator() -> Void {
        addItem(.separator())
    }
    
    func addItems(_ items: NSMenuItem...) {
        for item in items {
            addItem(item)
        }
    }
}
