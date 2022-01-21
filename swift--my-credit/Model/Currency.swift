//
//  Currency.swift
//  swift--my-credit
//
//  Created by Sergey Smirnov on 21.01.2022.
//

import Foundation

enum Currency: String {
    
    case rur = "₽"
    case usd = "$"
    case eur = "€"
    case gbp = "£"
    case jpy = "¥"
    
    var title: String {
        switch self {
        case .rur:
            return "rur"
        case .usd:
            return "usd"
        case .eur:
            return "eur"
        case .gbp:
            return "gbp"
        case .jpy:
            return "jpy"
        }
    }
}
