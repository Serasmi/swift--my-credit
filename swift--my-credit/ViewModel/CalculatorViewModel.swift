//
//  Calculator.swift
//  swift--my-credit
//
//  Created by Сергей Смирнов on 16.06.2021.
//

import Foundation

class CalculatorViewModel {
    private(set) var amount: Box<Double>
    private(set) var years: Box<Int>
    
    var currency: String
    var rate: Double {
        didSet { calculate() }
    }
    
    var payment: Double = 0
    var overPayment: Double = 0
    
    var formattedPayment: String {
        "\(payment.formatAsCurrency(with: currency))/month"
    }
    
    var formattedOverPayment: String {
        "\(overPayment.formatAsCurrency(with: currency))"
    }
    
    init(amount: Double, currency: String, years: Int, rate: Double) {
        self.amount = Box(amount)
        self.currency = currency
        self.years = Box(years)
        self.rate = rate
        
        calculate()
    }
    
    func setAmount(with value: Double) {
        if (amount.value != value) {
            amount.value = value
            calculate()
        }
    }
    
    func setYears(with value: Int) {
        if (years.value != value) {
            years.value = value
            calculate()
        }
    }
    
    func calculate() {
        guard years.value != 0, rate != 0 else { return }
        
        let months: Double = Double(years.value) * 12
        
        // month percents
        let mPs = rate / 100 / 12
        
        let coef = mPs * pow(1 + mPs, months) / (pow(1 + mPs, months) - 1)
        
        payment = amount.value * coef
        overPayment = months * payment - amount.value
    }
}

