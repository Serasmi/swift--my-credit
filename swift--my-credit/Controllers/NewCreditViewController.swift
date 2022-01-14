//
//  NewCreditViewController.swift
//  swift--my-credit
//
//  Created by Сергей Смирнов on 23.05.2021.
//

import UIKit

class NewCreditViewController: UIViewController {
    
    private let persistanceManager: PersistenceManager = CoreDataPersistenceManager()
    
    @IBOutlet weak var mainStackView: UIStackView!
    
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var currencyButton: UIButton!
    
    @IBOutlet weak var payment: UILabel!
    @IBOutlet weak var overPayment: UILabel!
    
    var saveAction: UIAlertAction?
    
    var calculatorViewModel: CalculatorViewModel!
    
    private var amountInput = MCInput(label: Constants.amountLabel,
                                      value: Constants.amount,
                                      minValue: Constants.amountMin,
                                      maxValue: Constants.amountMax)
    
    private let amountSlider = MCSlider(value: Constants.amount,
                                        minValue: Constants.amountMin,
                                        maxValue: Constants.amountMax,
                                        step: Constants.amountStep,
                                        minSuffix: Constants.defaultCurrency,
                                        maxSuffix: Constants.defaultCurrency)
    
    
    private var durationInput = MCInput(label: Constants.durationLabel,
                                        value: Constants.duration,
                                        minValue: Constants.durationMin,
                                        maxValue: Constants.durationMax)
    
    private let durationSlider = MCSlider(value: Constants.duration,
                                        minValue: Constants.durationMin,
                                        maxValue: Constants.durationMax,
                                        step: Constants.durationStep,
                                        minSuffix: Constants.durationSuffix,
                                        maxSuffix: Constants.durationSuffix)
    
    
    private var rateInput = MCInput(label: Constants.rateLabel,
                                        value: Constants.rate,
                                        minValue: Constants.rateMin,
                                        maxValue: Constants.rateMax)
    
    private let rateSlider = MCSlider(value: Constants.rate,
                                        minValue: Constants.rateMin,
                                        maxValue: Constants.rateMax,
                                        step: Constants.rateStep,
                                        minSuffix: Constants.rateSuffix,
                                        maxSuffix: Constants.rateSuffix)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainStackView.insertArrangedSubviews(amountInput,
                                             amountSlider,
                                             durationInput,
                                             durationSlider,
                                             rateInput,
                                             rateSlider,
                                             at: 0)
        
        initData()
        
        initCurrencyButton()
        
        boundListeners()
    }
    
    func initData() {
        calculatorViewModel = CalculatorViewModel(
            amount: Double(Constants.amount),
            currency: Constants.defaultCurrency,
            years: Int(Constants.duration),
            rate: Double(Constants.rate))
        
        updatePayments()
    }
    
    func initCurrencyButton() {
        currencyButton.backgroundColor = .clear
        currencyButton.layer.cornerRadius = 5
        currencyButton.layer.borderWidth = 1
        currencyButton.layer.borderColor = UIColor.systemGray6.cgColor
        currencyButton.setTitle(Constants.defaultCurrency, for: .normal)
    }
    
    private func boundListeners() {
        calculatorViewModel.amount.bind { [unowned self] in
            self.amountInput.setValue(with: Float($0))
            self.amountSlider.setValue(with: Float($0))
            
            updatePayments()
        }
        
        amountSlider.bind { [unowned self] in
            self.calculatorViewModel.setAmount(with: Double($0))
        }
        
        amountInput.bind { [unowned self] in
            self.calculatorViewModel.setAmount(with: Double($0))
        }
        
        calculatorViewModel.years.bind { [unowned self] in
            self.durationInput.setValue(with: Float($0))
            self.durationSlider.setValue(with: Float($0))
            
            updatePayments()
        }
        
        durationSlider.bind { [unowned self] in
            self.calculatorViewModel.setYears(with: Int($0))
        }
        
        durationInput.bind { [unowned self] in
            self.calculatorViewModel.setYears(with: Int($0))
        }
        
        calculatorViewModel.rate.bind { [unowned self] in
            self.rateInput.setValue(with: Float($0), precision: 1)
            self.rateSlider.setValue(with: Float($0))
            
            updatePayments()
        }
        
        rateSlider.bind { [unowned self] in
            self.calculatorViewModel.setRate(with: Double($0))
        }
        
        rateInput.bind { [unowned self] in
            self.calculatorViewModel.setRate(with: Double($0))
        }
    }
    
    @IBAction func tapCurrency(_ sender: UIButton) {
        let pickerWidth = UIScreen.main.bounds.width
        let pickerHeight: CGFloat = 200
        
        let vc = UIViewController()
        vc.preferredContentSize = CGSize(width: pickerWidth, height: pickerHeight)
        
        let pickerView = UIPickerView(frame: CGRect(x: 0, y: 0, width: pickerWidth, height: pickerHeight))
        pickerView.dataSource = self
        pickerView.delegate = self
        
        let selectedRow = Constants.currencyIndex(of: calculatorViewModel.currency)
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
            
            self.calculatorViewModel.currency = newCurrencyValue
            self.currencyButton.setTitle(newCurrencyValue, for: .normal)
            
            self.updatePayments()
            self.updateCurrencyLabels()
        }))
        
        self.present(alertMessage, animated: true, completion: nil)
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
                let creditDraft = CreditDraft(amount: self.calculatorViewModel.amount.value,
                                              currency: self.calculatorViewModel.currency,
                                              duration: self.calculatorViewModel.years.value,
                                              overPayment: Float(self.calculatorViewModel.overPayment),
                                              payment: Float(self.calculatorViewModel.payment),
                                              rate: Float(self.calculatorViewModel.rate.value),
                                              title: creditTitle)
                
                self.persistanceManager.saveCredit(creditDraft)
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
    
    private func updateCurrencyLabels() {
        amountSlider.updateMinSuffix(with: calculatorViewModel.currency)
        amountSlider.updateMaxSuffix(with: calculatorViewModel.currency)
    }
    
    private func updatePayments() {
        payment.text = calculatorViewModel.formattedPayment
        overPayment.text = calculatorViewModel.formattedOverPayment
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
