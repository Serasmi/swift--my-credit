//
//  Constants.swift
//  swift--my-credit
//
//  Created by Сергей Смирнов on 04.06.2021.
//

import UIKit


struct Constants {
    static let currencies = ["₽", "$", "€", "£", "¥"]
    
    static func currencyIndex(of currency: String) -> Int {
        Constants.currencies.firstIndex(of: currency) ?? 0
    }
    
    static let defaultCurrency = "$"
    
    static var defaultCurrencyIndex: Int {
        Constants.currencyIndex(of: Constants.defaultCurrency)
    }
    
    // MARK: - amount constants
    static let amount: Float = 1_000_000
    static let amountMin: Float = 1_000
    static let amountMax: Float = 10_000_000
    static let amountStep: Float = 1_000
    static let amountLabel = "Credit amount"
    
    static let defaultDuration = 20
    
    static let defaultRate = 9.6
    
    static let durationId = "durationId"
    
    static let rateId = "rateId"
    
    static let padding: CGFloat = 16
    
    // MARK: - input constants
    
    static let inputMinValue: Float = 0
    static let inputMaxValue: Float = 10_000
    static let inputCornerRadius: CGFloat = 8
    static let paddingInput: CGFloat = 12
    
    // MARK: - slider constants
    
    static let sliderStep: Float = 1
    static let sliderColor: UIColor = .systemGreen
    static let sliderMinValue: Float = 0
    static let sliderMaxValue: Float = 100
    
}
