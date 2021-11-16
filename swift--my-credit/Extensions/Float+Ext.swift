//
//  Float+Ext.swift
//  swift--my-credit
//
//  Created by Sergey Smirnov on 16.11.2021.
//

extension Float {
    
    func round(to precision: UInt = 0) -> String {
        let formatPattern = "%.\(precision)f"
        return String(format: formatPattern, self)
    }
    
}
