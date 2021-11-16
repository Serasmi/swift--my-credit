//
//  TestVC.swift
//  swift--my-credit
//
//  Created by Sergey Smirnov on 16.11.2021.
//

import UIKit

class TestVC: UIViewController {
    
    private let amountSlider = MCSlider(value: 1_000_000,
                                        minValue: 1_000,
                                        maxValue: 10_000_000,
                                        step: 1_000,
                                        minSuffix: "$",
                                        maxSuffix: "$")

    override func viewDidLoad() {
        super.viewDidLoad()
        
        amountSlider.delegate = self
        
        view.addSubview(amountSlider)

        configureSlider()
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
        print("slider value: \(value)")
    }
}
