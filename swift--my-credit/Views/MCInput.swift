//
//  MCInput.swift
//  swift--my-credit
//
//  Created by Sergey Smirnov on 17.11.2021.
//

import UIKit

class MCInput: UIView {

    var value: Float = 0 {
        didSet {
            textField.text = value.round()
        }
    }
    
    private let label = UILabel()
    private let textField = UITextField(frame: .zero)

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(label)
        addSubview(textField)
        
        configureLabel()
        configureTextField()
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(label: String,
                     value: Float,
                     minValue: Float = Constants.inputMinValue,
                     maxValue: Float = Constants.inputMaxValue) {
        self.init(frame: .zero)
        
        self.label.text = label
        
        self.value = value
        textField.text = value.round()
    }
    
    private func configureLabel() {
        label.textColor = .systemGray
        label.font = .systemFont(ofSize: 14)
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.paddingInput),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.paddingInput),
            label.topAnchor.constraint(equalTo: topAnchor, constant: Constants.paddingInput)
        ])
        
        label.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureTextField() {
        textField.font = .systemFont(ofSize: 18)
        textField.keyboardType = .numberPad
        
        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.paddingInput),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.paddingInput),
            textField.topAnchor.constraint(equalTo: label.bottomAnchor),
            textField.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constants.paddingInput)
        ])
        
        textField.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureView() {
        backgroundColor = .systemGray6
        
        layer.cornerRadius = Constants.inputCornerRadius
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
}
