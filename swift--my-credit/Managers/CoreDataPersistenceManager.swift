//
//  CoreDataPersistenceManager.swift
//  swift--my-credit
//
//  Created by Sergey Smirnov on 14.01.2022.
//

import Foundation
import UIKit

class CoreDataPersistenceManager: PersistenceManager {
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private let saveContext = (UIApplication.shared.delegate as! AppDelegate).saveContext
    
    public static let shared = CoreDataPersistenceManager()
    
    // TODO: implements logic. Should return Credit by id
    public func getCredit(by id: UUID) {
        
    }
    
    public func saveCredit(_ credit: CreditDraft) {
        let newCreditItem = CreditItem(context: context)
        
        newCreditItem.amount = Int64(credit.amount)
        newCreditItem.createdAt = Date()
        newCreditItem.currency = credit.currency
        newCreditItem.duration = Int64(credit.duration)
        newCreditItem.id = UUID()
        newCreditItem.overPayment = credit.overPayment
        newCreditItem.payment = credit.payment
        newCreditItem.rate = credit.rate
        newCreditItem.title = credit.title
        
        saveContext();
    }
}
