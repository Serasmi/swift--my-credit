//
//  Box.swift
//  swift--my-credit
//
//  Created by Sergey Smirnov on 09.12.2021.
//

import Foundation

final class Box<T: Equatable> {
    typealias Listener = (T) -> Void
    
    private var listener: Listener?
    
    
    var value: T {
        didSet {
            if oldValue != value {
                listener?(value)
            }
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(listener: Listener?) {
        self.listener = listener
        listener?(value)
    }
}
