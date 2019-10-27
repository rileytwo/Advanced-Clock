//
//  Bool+Extension.swift
//  Advanced Clock
//
//  Created by Riley Roach on 10/27/19.
//  Copyright © 2019 Riley Roach. All rights reserved.
//

import Foundation
import AppKit


extension Bool {
    var stateValue: NSControl.StateValue {
        return self.toStateValue()
    }
    
    
    private func toStateValue() -> NSControl.StateValue {
        return self ? .on : .off
    }
}
