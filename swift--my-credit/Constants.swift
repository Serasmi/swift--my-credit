//
//  Constants.swift
//  swift--my-credit
//
//  Created by Сергей Смирнов on 04.06.2021.
//

import Foundation


class Constants {
    static let currencies = ["₽", "$", "€", "£", "¥"]
    
    static let defaultCurrency = "$"
    
    static var defaultCurrencyIndex: Int {
        Constants.currencies.firstIndex(of: Constants.defaultCurrency) ?? 0
    }
}
