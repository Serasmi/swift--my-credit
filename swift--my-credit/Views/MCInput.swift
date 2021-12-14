//
//  MCInput.swift
//  swift--my-credit
//
//  Created by Sergey Smirnov on 17.11.2021.
//

import UIKit

class MCInput: UIView {
    
    typealias Listener = (Float) -> Void
    
    private var listener: Listener?
    
    private let label = UILabel()
    private let textField = UITextField(frame: .zero)
    
    private(set) var minimumValue: Float = Constants.inputMinValue
    private(set) var maximumValue: Float = Constants.inputMaxValue

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        textField.delegate = self
        
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
        
        minimumValue = minValue
        maximumValue = maxValue
        
        self.label.text = label
        setValue(with: value)
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
        
        textField.addTarget(self, action: #selector(changeValue), for: .editingChanged)
        
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
    
    @objc
    private func changeValue(_ sender: UITextField) {
        let normalizedValue = sender.text?.toFloat() ?? 0
        textField.text = normalizedValue.round()
        
        self.listener?(normalizedValue)
    }

    private func normalizeValue() {
        let normalizedValue = textField.text?.toFloat() ?? 0
        
        if (normalizedValue < minimumValue) {
            textField.text = minimumValue.round()
            return
        }
        
        if (normalizedValue > maximumValue) {
            textField.text = maximumValue.round()
            return
        }
    }
    
    func bind(listener: Listener?) {
        self.listener = listener
        listener?(textField.text?.toFloat() ?? 0)
    }
    
    func setValue(with value: Float, precision: UInt = 0) {
        let newValue = value.round(to: precision)
        
        if (newValue != textField.text) {
            textField.text = newValue
            listener?(value)
        }
    }
}

extension MCInput: UITextFieldDelegate {
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        normalizeValue()
        return true
    }
}
