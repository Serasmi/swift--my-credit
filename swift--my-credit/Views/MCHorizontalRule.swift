//
//  MCHorizontalRule.swift
//  swift--my-credit
//
//  Created by Sergey Smirnov on 17.01.2022.
//

import UIKit

class MCHorizontalRule: UIView {
    
    private(set) var padding: CGFloat = 5
    private(set) var color: UIColor = .systemGray4
    private(set) var weight: CGFloat = 1
    
    private let divider = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(divider)
        
        configureDivider()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureDivider() {
        divider.backgroundColor = color
        
        NSLayoutConstraint.activate([
            divider.leadingAnchor.constraint(equalTo: leadingAnchor),
            divider.trailingAnchor.constraint(equalTo: trailingAnchor),
            divider.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            divider.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding),
            divider.heightAnchor.constraint(equalToConstant: weight)
        ])
        
        divider.translatesAutoresizingMaskIntoConstraints = false
    }
}
