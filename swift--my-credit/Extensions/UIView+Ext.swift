//
//  View+Ext.swift
//  swift--my-credit
//
//  Created by Sergey Smirnov on 16.11.2021.
//

import UIKit

extension UIView {
    
    /// Adds views to the end of the receiver’s list of subviews.
    /// - Parameter views: Views to be added. After being added, these views appear on top of any other subviews.
    func addSubviews(_ views: UIView...) {
        views.forEach { addSubview($0) }
    }
    
}
