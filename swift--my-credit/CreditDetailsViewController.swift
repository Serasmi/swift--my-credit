//
//  CreditDetailsViewController.swift
//  swift--my-credit
//
//  Created by Сергей Смирнов on 02.06.2021.
//

import UIKit

class CreditDetailsViewController: UIViewController {
    var creditItem: CreditItem!

    @IBOutlet weak var titleView: UILabel!
    @IBOutlet weak var amountView: UILabel!
    @IBOutlet weak var durationView: UILabel!
    @IBOutlet weak var rateView: UILabel!
    @IBOutlet weak var paymentView: UILabel!
    @IBOutlet weak var overPaymentView: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initCredit()
    }
    
    private func initCredit() {
        titleView.text = creditItem.title
        amountView.text = "\(creditItem.amount) \(creditItem.currency ?? Constants.defaultCurrency)"
        durationView.text = "\(creditItem.duration / 12) year(s)"
        rateView.text = "\(creditItem.rate)%"
        paymentView.text = "\(creditItem.payment) \(creditItem.currency ?? Constants.defaultCurrency)/month"
        overPaymentView.text = "\(creditItem.overPayment) \(creditItem.currency ?? Constants.defaultCurrency)"
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
