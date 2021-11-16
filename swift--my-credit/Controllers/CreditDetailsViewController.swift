//
//  CreditDetailsViewController.swift
//  swift--my-credit
//
//  Created by Сергей Смирнов on 02.06.2021.
//

import UIKit

class CreditDetailsViewController: UIViewController {
    var creditItem: CreditItem!

    @IBOutlet weak var amountView: UILabel!
    @IBOutlet weak var durationView: UILabel!
    @IBOutlet weak var rateView: UILabel!
    @IBOutlet weak var paymentView: UILabel!
    @IBOutlet weak var overPaymentView: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initUI()
        initCredit()
    }
    
    private func initUI() {
        navigationItem.title = creditItem.title
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Delete", style: .plain, target: self, action: #selector(tapDelete))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(tapEdit))
    }
    
    private func initCredit() {
//        amountView.text = "\(creditItem.amount) \(creditItem.currency ?? Constants.defaultCurrency)"
        amountView.text = "\(Double(creditItem.amount).formatAsCurrency(with: creditItem.currency, fractionDigits: 0))"
        durationView.text = "\(creditItem.duration / 12) year(s)"
        rateView.text = "\(creditItem.rate)%"
        paymentView.text = "\(Double(creditItem.payment).formatAsCurrency(with: creditItem.currency))/month"
        overPaymentView.text = "\(Double(creditItem.overPayment).formatAsCurrency(with: creditItem.currency))"
    }
    
    @objc func tapEdit() {
        print("Edit credit tapped")
    }
    
    @objc func tapDelete() {
        print("Delete credit tapped")
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
