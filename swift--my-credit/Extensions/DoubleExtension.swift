//
//  DoubleExtension.swift
//  swift--my-credit
//
//  Created by Сергей Смирнов on 22.06.2021.
//

import Foundation

extension Double {
    func formatAsCurrency(with currencySymbol: String? = Constants.defaultCurrency, fractionDigits: Int = 2) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = currencySymbol ?? Constants.defaultCurrency
        formatter.locale = Locale(identifier: "ru")
        formatter.maximumFractionDigits = fractionDigits
        return formatter.string(from: NSNumber(value: self)) ?? "0"
    }
}
