//
//  Calculator.swift
//  swift--my-credit
//
//  Created by Сергей Смирнов on 16.06.2021.
//

import Foundation

struct Calculator {
    var amount: Double {
        didSet { calculate() }
    }
    var currency: String
    var months: Int {
        didSet { calculate() }
    }
    var rate: Double {
        didSet { calculate() }
    }
    
    var payment: Double = 0
    var overPayment: Double = 0
    
    var formattedPayment: String {
        "\(String(format: "%.2f",  payment)) \(currency)/month"
    }
    
    var formattedOverPayment: String {
        "\(String(format: "%.2f",  overPayment)) \(currency)"
    }
    
    init(amount: Double, currency: String, months: Int, rate: Double) {
        self.amount = amount
        self.currency = currency
        self.months = months
        self.rate = rate
        
        calculate()
    }
    
    mutating func calculate() {
        guard self.months != 0, rate != 0 else { return }
        
        let months: Double = Double(months)
        
        // month percents
        let mPs = rate / 100 / 12
        
        let coef = mPs * pow(1 + mPs, months) / (pow(1 + mPs, months) - 1)
        
        payment = amount * coef
        overPayment = months * payment - amount
    }
}

