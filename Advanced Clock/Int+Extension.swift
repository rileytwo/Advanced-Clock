//
//  Int+Extension.swift
//  Advanced Clock
//
//  Created by Riley Roach on 10/27/19.
//  Copyright © 2019 Riley Roach. All rights reserved.
//

import Foundation


extension Int {
    /// ---
    ///    var n: Int 5
    ///    n = n.safeString
    ///    print(n) // "05"
    /// ---
    
    var safeString: String {
        return self >= 10 ? "\(self)" : "0\(self)"
    }
}
