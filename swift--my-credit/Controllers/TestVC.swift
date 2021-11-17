//
//  TestVC.swift
//  swift--my-credit
//
//  Created by Sergey Smirnov on 16.11.2021.
//

import UIKit

fileprivate struct Defaults {
    static let amount: Float = 1_000_000
    static let amountMin: Float = 1_000
    static let amountMax: Float = 10_000_000
}

class TestVC: UIViewController {
    
    private let amountInput = MCInput(label: "Сумма кредита",
                                      value: Defaults.amount,
                                      minValue: Defaults.amountMin,
                                      maxValue: Defaults.amountMax)
    
    private let amountSlider = MCSlider(value: Defaults.amount,
                                        minValue: Defaults.amountMin,
                                        maxValue: Defaults.amountMax,
                                        step: 1_000,
                                        minSuffix: "$",
                                        maxSuffix: "$")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        amountSlider.delegate = self
        
        view.addSubview(amountInput)
        view.addSubview(amountSlider)
        
        configureInput()
        configureSlider()
    }
    
    private func configureInput() {
        NSLayoutConstraint.activate([
            amountInput.bottomAnchor.constraint(equalTo: amountSlider.topAnchor, constant: -Constants.padding),
            amountInput.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.padding),
            amountInput.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.padding)
        ])
        
        amountInput.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func configureSlider() {
        NSLayoutConstraint.activate([
            amountSlider.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            amountSlider.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.padding),
            amountSlider.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.padding)
        ])
        
        amountSlider.translatesAutoresizingMaskIntoConstraints = false
    }
    
}

extension TestVC: MCSliderDelegate {
    
    func slider(_ slider: UISlider, value: Float) {
        amountInput.value = value
    }
}
