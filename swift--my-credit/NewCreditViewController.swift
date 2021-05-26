//
//  NewCreditViewController.swift
//  swift--my-credit
//
//  Created by Сергей Смирнов on 23.05.2021.
//

import UIKit

class NewCreditViewController: UIViewController {

    @IBOutlet weak var amount: UITextField!
    @IBOutlet weak var duration: UITextField!
    @IBOutlet weak var rate: UITextField!
    
    @IBOutlet weak var payment: UILabel!
    @IBOutlet weak var overPayment: UILabel!
    
    var saveAction: UIAlertAction?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        calculate()
    }
    
    @IBAction func calculate() {
        let monthPayment = calcMonthPayment()
        let fullOverPayment = calcOverPayment(perMonth: monthPayment)
        
        print(monthPayment)
        
        payment.text = "\(Int(monthPayment)) ₽/month"
        overPayment.text = "\(Int(fullOverPayment)) ₽"
    }
    
    func calcMonthPayment() -> Double {
        guard let creditAmount = Double(amount.text!),
              var mD = Double(duration.text!)
        else {
            return 0
        }
        
        if (mD == 0) { return 0 }
        
        // converts to months
        mD *= 12
        
        guard let creditRate = Double(rate.text!) else {
            return 0
        }
        
        if (creditRate == 0) { return 0 }
        
        // month percents
        let mPs = creditRate / 100 / 12
        
        // coeffitient
        let k: Double = mPs * pow(1 + mPs, mD) / (pow(1 + mPs, mD) - 1)

        return creditAmount * k
    }
    
    func calcOverPayment(perMonth: Double) -> Double {
        guard let creditAmount = Double(amount.text!),
              var mD = Double(duration.text!)
        else {
            return 0
        }
        
        // converts to months
        mD *= 12
        
        return mD * perMonth - creditAmount;
    }
    
    func saveCredit(with title: String) {
        
    }
    
    @IBAction func showAlert(_ sender: Any) {
        let alertMessage = UIAlertController(title: "Credit title", message: "Enter credit title and save", preferredStyle: .alert)
        
        alertMessage.addTextField { textField in
            textField.placeholder = "Credit title"
            textField.addTarget(self, action: #selector(self.textChanged), for: .editingChanged)
        }
        
        alertMessage.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        let saveAction = UIAlertAction(title: "Save", style: .default, handler: { action in
            if let creditTitle = alertMessage.textFields?.first?.text {
                self.saveCredit(with: creditTitle)
            }
        })
        saveAction.isEnabled = false
        self.saveAction = saveAction
        
        alertMessage.addAction(saveAction)
        
        self.present(alertMessage, animated: true, completion: nil)
    }
    
    @objc func textChanged(sender: UITextField) {
        self.saveAction?.isEnabled = (sender.text?.count ?? 0 > 0)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if touches.first != nil {
            view.endEditing(true)
        }
        
        super.touchesBegan(touches, with: event)
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
