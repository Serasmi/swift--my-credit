//
//  PersistenceManager.swift
//  swift--my-credit
//
//  Created by Sergey Smirnov on 14.01.2022.
//

import Foundation

protocol PersistenceManager {
    
    // TODO: should return Credit item by id
    func getCredit(by id: UUID)
    
    func saveCredit(_ credit: CreditDraft)
}
