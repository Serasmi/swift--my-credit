//
//  Constants.swift
//  swift--my-credit
//
//  Created by Сергей Смирнов on 04.06.2021.
//

import Foundation


class Constants {
    static let currencies = ["₽", "$", "€", "£", "¥"]
    
    static func currencyIndex(of currency: String) -> Int {
        Constants.currencies.firstIndex(of: currency) ?? 0
    }
    
    static let defaultCurrency = "$"
    
    static var defaultCurrencyIndex: Int {
        Constants.currencyIndex(of: Constants.defaultCurrency)
    }
    
    static let defaultAmount = 12_000_000.0
    
    static let defaultDuration = 20
    
    static let defaultRate = 9.6
    
    static let amountId = "amountId"
    
    static let durationId = "durationId"
    
    static let rateId = "rateId"
}
