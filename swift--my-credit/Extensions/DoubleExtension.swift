//
//  DoubleExtension.swift
//  swift--my-credit
//
//  Created by Сергей Смирнов on 22.06.2021.
//

import Foundation

extension Double {
    func formatAsCurrency(with currencySymbol: String? = Constants.defaultCurrency) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = currencySymbol
        formatter.locale = Locale(identifier: "ru")
        formatter.maximumFractionDigits = 2
        return formatter.string(from: NSNumber(value: self)) ?? "0"
    }
}
