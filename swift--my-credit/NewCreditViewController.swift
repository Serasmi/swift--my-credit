//
//  NewCreditViewController.swift
//  swift--my-credit
//
//  Created by Сергей Смирнов on 23.05.2021.
//

import UIKit

class NewCreditViewController: UIViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let saveContext = (UIApplication.shared.delegate as! AppDelegate).saveContext
    
    @IBOutlet weak var amount: UITextField!
    @IBOutlet weak var duration: UITextField!
    @IBOutlet weak var rate: UITextField!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var currencyButton: UIButton!
    
    @IBOutlet weak var payment: UILabel!
    @IBOutlet weak var overPayment: UILabel!
    
    var saveAction: UIAlertAction?
    
    var paymentValue: Double = 0
    var overPaymentValue: Double = 0
    
    var calculator: Calculator!
    
    var selectedCurrencyIndex = Constants.defaultCurrencyIndex
    var selectedCurrency: String {
        get {
            Constants.currencies[selectedCurrencyIndex]
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        amount.accessibilityIdentifier = Constants.amountId
        duration.accessibilityIdentifier = Constants.durationId
        rate.accessibilityIdentifier = Constants.rateId
        
        initData()
        
        initCurrencyButton()
    }
    
    @IBAction func calculate(_ sender: UITextField) {
        // todo: split func => changeAmount, changeRate, changeDuration or switch-case
        let senderId: String = sender.accessibilityIdentifier ?? ""
        
        switch senderId {
        case Constants.amountId:
            calculator.amount = Double(sender.text ?? "0") ?? 0
        case Constants.durationId:
            calculator.months = (Int(sender.text ?? "0") ?? 0) * 12
        case Constants.rateId:
            calculator.rate = Double(sender.text ?? "0") ?? 0
        default:
            fatalError("Unknown field identifier")
        }
        
        updatePayments()
    }
    
    @IBAction func tapCurrency(_ sender: UIButton) {
        let pickerWidth = UIScreen.main.bounds.width
        let pickerHeight: CGFloat = 200
        
        let vc = UIViewController()
        vc.preferredContentSize = CGSize(width: pickerWidth, height: pickerHeight)
        
        let pickerView = UIPickerView(frame: CGRect(x: 0, y: 0, width: pickerWidth, height: pickerHeight))
        pickerView.dataSource = self
        pickerView.delegate = self
        
        let selectedRow = Constants.currencyIndex(of: calculator.currency)
        pickerView.selectRow(selectedRow, inComponent: 0, animated: false)
        
        vc.view.addSubview(pickerView)
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        
        pickerView.centerXAnchor.constraint(equalTo: vc.view.centerXAnchor).isActive = true
        pickerView.centerYAnchor.constraint(equalTo: vc.view.centerYAnchor).isActive = true
        
        
        let alertMessage = UIAlertController(title: "Select currency", message: nil, preferredStyle: .actionSheet)
        
        alertMessage.setValue(vc, forKey: "contentViewController")
        
        alertMessage.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alertMessage.addAction(UIAlertAction(title: "Save", style: .default, handler: { action in
            let newSelectedRow = pickerView.selectedRow(inComponent: 0)
            let newCurrencyValue = Constants.currencies[newSelectedRow]
            
            self.calculator.currency = newCurrencyValue
            self.currencyButton.setTitle(newCurrencyValue, for: .normal)
            
            self.updatePayments()
        }))
        
        self.present(alertMessage, animated: true, completion: nil)
    }
    
    func updatePayments() {
        payment.text = calculator.formattedPayment
        overPayment.text = calculator.formattedOverPayment
    }
    
    func initData() {
        calculator = Calculator(amount: Constants.defaultAmount,
                                currency: Constants.defaultCurrency,
                                months: Constants.defaultDuration * 12,
                                rate: Constants.defaultRate)
        
        amount.text = String(Constants.defaultAmount)
        duration.text = String(Constants.defaultDuration)
        rate.text = String(Constants.defaultRate)
        
        updatePayments()
    }
    
    func initCurrencyButton() {
        currencyButton.backgroundColor = .clear
        currencyButton.layer.cornerRadius = 5
        currencyButton.layer.borderWidth = 1
        currencyButton.layer.borderColor = UIColor.systemGray6.cgColor
        currencyButton.setTitle(Constants.defaultCurrency, for: .normal)
    }
    
    func saveCredit(with title: String) {
        // todo: get data from Calculator model instead of UITextFields
        let newCreditItem = CreditItem(context: context)
        
        newCreditItem.amount = Int64(amount.text ?? "0") ?? 0
        newCreditItem.createdAt = Date()
        newCreditItem.currency = selectedCurrency
        newCreditItem.duration = Int64(duration.text ?? "0") ?? 0
        newCreditItem.id = UUID()
        newCreditItem.overPayment = Float(overPaymentValue)
        newCreditItem.payment = Float(paymentValue)
        newCreditItem.rate = Float(rate.text ?? "0") ?? 0
        newCreditItem.title = title
        
        saveContext();
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
}

extension NewCreditViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Constants.currencies.count
    }
}

extension NewCreditViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Constants.currencies[row]
    }
}
