//
//  StackView+Ext.swift
//  swift--my-credit
//
//  Created by Sergey Smirnov on 22.11.2021.
//

import UIKit

extension UIStackView {
    
    
    /// Adds the provided views to the array of arranged subviews at the specified index.
    /// - Parameters:
    ///   - views: The views to be added to the array of views arranged by the stack.
    ///   - stackIndex: The index where the stack inserts the new views in its arrangedSubviews array. This value must not be greater than the number of views currently in this array. If the index is out of bounds, this method throws an internalInconsistencyException exception.
    func insertArrangedSubviews(_ views: UIView..., at stackIndex: Int = 0) {
        for (index, view) in views.enumerated() {
            insertArrangedSubview(view, at: stackIndex + index)
        }
    }
    
}
