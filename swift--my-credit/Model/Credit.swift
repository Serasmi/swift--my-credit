//
//  Credit.swift
//  swift--my-credit
//
//  Created by Sergey Smirnov on 14.01.2022.
//

import Foundation

struct Credit {
    var amount: Double
    var createdAt: Date
    var currency: String
    var duration: Int
    var id: UUID
    var overPayment: Float
    var payment: Float
    var rate: Float
    var title: String
}

struct CreditDraft {
    var amount: Double
    var currency: String
    var duration: Int
    var overPayment: Float
    var payment: Float
    var rate: Float
    var title: String
}
