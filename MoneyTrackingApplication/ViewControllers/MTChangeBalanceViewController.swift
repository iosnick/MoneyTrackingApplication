//
//  MTChangeBalanceViewController.swift
//  MoneyTrackingApplication
//
//  Created by Вадим Бенько on 11.03.2021.
//

import UIKit

class MTChangeBalanceViewController: UIViewController {
    // MARK: - Variables
    private let category = ["", "Food", "Car", "Clothes", "Furniture",
                            "Games", "Computer", "Electronics", "Entertainments", "Salary", "Other"]
    private var flag: Bool = true
    
    // MARK: - GUI Variables
    private lazy var addToBalanceLabel: MTCustomLabel = {
        let label = MTCustomLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setLabelProperties(textColor: .white, text: "Add to Balance",
                                 textAlignment: .center, font: UIFont.boldSystemFont(ofSize: 18), lines: 1)
        return label
    }()
    private lazy var currentBalanceLabel: MTCustomLabel = {
        let label = MTCustomLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setLabelProperties(textColor: .white, text: "$7777",
                                 textAlignment: .center, font: UIFont.boldSystemFont(ofSize: 48), lines: 1)
        return label
    }()
    private lazy var currentlyInYourWalletLabel: MTCustomLabel = {
        let label = MTCustomLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setLabelProperties(textColor: .white, text: "currently in your wallet",
                                 textAlignment: .center, font: UIFont.systemFont(ofSize: 13), lines: 1)
        return label
    }()
    private lazy var segmentedControl: UISegmentedControl = {
        let items = ["Income", "Outcome"]
        
        let control = UISegmentedControl(items: items)
        control.selectedSegmentIndex = 0
        control.addTarget(self, action: #selector(self.didChangeSegment(_:)), for: .valueChanged)
        control.translatesAutoresizingMaskIntoConstraints = false
        control.selectedSegmentTintColor = UIColor(red: 136/255, green: 134/255, blue: 251/255, alpha: 1)
        control.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white,
                                        NSAttributedString.Key.font: UIFont.systemFont(ofSize: 19)], for: .normal)
        return control
    }()
    private lazy var categoryTextField: MTCustomTextField = {
        let textField = MTCustomTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.setTextFieldProperties(placeHolderText: "Tap to select category", cornerRadius: 15,
                                         borderColor: UIColor(red: 68.0/255.0, green: 71.0/255.0, blue: 234.0/255.0, alpha: 1.0).cgColor)
        let viewForText = UIView()
        viewForText.frame = CGRect(x: 0, y: 0, width: 17, height: 42)
        textField.addSubview(viewForText)
        textField.leftView = viewForText
        textField.leftViewMode = UITextField.ViewMode.always
        return textField
    }()
    private lazy var viewWithCategoryLabel: UIView = {
        let view = UIView()
        let label = MTCustomLabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 27/255, green: 30/255, blue: 37/255, alpha: 1)
        label.setLabelProperties(textColor: UIColor(white: 1, alpha: 1),
                                 text: "Category",
                                 textAlignment: .center,
                                 font: .boldSystemFont(ofSize: 11))
        label.frame = CGRect(x: 0, y: 0, width: 68, height: 16)
        view.addSubview(label)
        return view
    }()
    private lazy var howMuchMoney: MTCustomLabel = {
        let label = MTCustomLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setLabelProperties(textColor: .white, text: "How much would you like to add?",
                                 textAlignment: .center, font: UIFont.systemFont(ofSize: 16), lines: 1)
        return label
    }()
    private lazy var enterMoney: MTCustomTextField = {
        let textField = MTCustomTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.setTextFieldProperties(placeHolderText: "999999", textFont: UIFont.systemFont(ofSize: 16), cornerRadius: 15,
                                         borderColor: UIColor(red: 68.0/255.0, green: 71.0/255.0, blue: 234.0/255.0, alpha: 1.0).cgColor)
        textField.addLeftIconDollar()
        textField.keyboardType = .phonePad
        return textField
    }()
    private lazy var addToWalletButton: MTCustomButton = {
        let button = MTCustomButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setButtonProperties(title: "Add to Wallet",
                                   cornerRadius: 20,
                                   titleColor: .white,
                                   backgroundColor: UIColor(red: 68.0/255.0, green: 71.0/255.0, blue: 234.0/255.0, alpha: 1.0))
        button.addTarget(self, action: #selector(self.changeBalance), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
                
        self.view.backgroundColor = UIColor(red: 27/255, green: 30/255, blue: 37/255, alpha: 1)
        self.view.addSubviews([self.addToBalanceLabel, self.currentlyInYourWalletLabel, self.segmentedControl,
                               self.categoryTextField, self.viewWithCategoryLabel, self.currentBalanceLabel,
                               self.howMuchMoney, self.enterMoney, self.addToWalletButton])
        
        self.addConstraints()
        self.addPickerView()
        self.keyboardHideWhenTappedAround()
        self.textFieldDelegate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.registerForKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.unregisterFromKeyboardNotifications()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.getCurrentBalance()
        self.addGradient()
    }
    
    // MARK: - Methods
    @objc private func didChangeSegment(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            self.flag = true
        } else if sender.selectedSegmentIndex == 1 {
            self.flag = false
        }
    }
    
    @objc private func changeBalance() {
        if !self.categoryTextField.text!.isEmpty, !self.enterMoney.text!.isEmpty {
            let parametrs = self.categoryTextField.text!
            let currentFlag = self.flag
            let sum = Int64(self.enterMoney.text!)!
            
            let balanceArray = CoreDataManager.shared.readBalance()
            var mainBalance = balanceArray[0]
            var income = balanceArray[1]
            var outcome = balanceArray[2]
            CoreDataManager.shared.remove(from: "Balance")

            if currentFlag == true {
                income = income + sum
                mainBalance = mainBalance + sum
            } else {
                outcome = outcome + sum
                mainBalance = mainBalance - sum
            }
            
            CoreDataManager.shared.writeDataInBalance(mainBalance: mainBalance, income: income, outcome: outcome)
            CoreDataManager.shared.writeDataInCategory(parametrs: parametrs, sum: sum, flag: currentFlag)

            let vc = MTTabBarViewController()
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: false, completion: nil)
        } else {
            self.showAlert()
        }
    }
    
    private func getCurrentBalance() {
        let resultArray = CoreDataManager.shared.readBalance()

        self.currentBalanceLabel.text = String("$\(resultArray[0])")
    }
    
    private func addPickerView() {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        
        self.categoryTextField.inputView = pickerView
    }
    
    private func addGradient() {
        self.addToWalletButton.setupGradient(buttonCornerRadius: self.addToWalletButton.layer.cornerRadius,
                                             bounds: self.addToWalletButton.bounds)
    }
    
    private func textFieldDelegate() {
        self.categoryTextField.delegate = self
        self.enterMoney.delegate = self
    }
    
    // MARK: - Alerts
    private func showAlert() {
        let alert = UIAlertController(title: "Oops!", message: "Category or sum is empty!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .destructive, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Add constraints
    private func addConstraints() {
        var constraints = [NSLayoutConstraint]()
        
        // Add
        constraints.append(addToBalanceLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 63))
        constraints.append(addToBalanceLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 117))
        constraints.append(addToBalanceLabel.widthAnchor.constraint(equalToConstant: 142))
        constraints.append(addToBalanceLabel.heightAnchor.constraint(equalToConstant: 22))
        
        constraints.append(currentBalanceLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 109))
        constraints.append(currentBalanceLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 54))
        constraints.append(currentBalanceLabel.widthAnchor.constraint(equalToConstant: 269))
        constraints.append(currentBalanceLabel.heightAnchor.constraint(equalToConstant: 59))
        
        constraints.append(currentlyInYourWalletLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 164))
        constraints.append(currentlyInYourWalletLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 113))
        constraints.append(currentlyInYourWalletLabel.widthAnchor.constraint(equalToConstant: 150))
        constraints.append(currentlyInYourWalletLabel.heightAnchor.constraint(equalToConstant: 16))
        
        constraints.append(segmentedControl.topAnchor.constraint(equalTo: view.topAnchor, constant: 206))
        constraints.append(segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24))
        constraints.append(segmentedControl.widthAnchor.constraint(equalToConstant: 327))
        constraints.append(segmentedControl.heightAnchor.constraint(equalToConstant: 38))
        
        constraints.append(categoryTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24))
        constraints.append(categoryTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 283))
        constraints.append(categoryTextField.widthAnchor.constraint(equalToConstant: 327))
        constraints.append(categoryTextField.heightAnchor.constraint(equalToConstant: 42))
        
        constraints.append(viewWithCategoryLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 264))
        constraints.append(viewWithCategoryLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 276))
        constraints.append(viewWithCategoryLabel.widthAnchor.constraint(equalToConstant: 68))
        constraints.append(viewWithCategoryLabel.heightAnchor.constraint(equalToConstant: 16))
        
        constraints.append(howMuchMoney.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50))
        constraints.append(howMuchMoney.topAnchor.constraint(equalTo: view.topAnchor, constant: 370))
        constraints.append(howMuchMoney.widthAnchor.constraint(equalToConstant: 277))
        constraints.append(howMuchMoney.heightAnchor.constraint(equalToConstant: 20))
        
        constraints.append(enterMoney.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 115))
        constraints.append(enterMoney.topAnchor.constraint(equalTo: view.topAnchor, constant: 398))
        constraints.append(enterMoney.widthAnchor.constraint(equalToConstant: 146))
        constraints.append(enterMoney.heightAnchor.constraint(equalToConstant: 32))
        
        constraints.append(addToWalletButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 692))
        constraints.append(addToWalletButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 52))
        constraints.append(addToWalletButton.widthAnchor.constraint(equalToConstant: 272))
        constraints.append(addToWalletButton.heightAnchor.constraint(equalToConstant: 44))
        
        // Activate (Applying)
        NSLayoutConstraint.activate(constraints)
    }
    
    // MARK: - Keyboard methods
    @objc private func keyboardWillShow(_ notification: Notification) { }
    
    @objc private func keyboardWillHide() { }
    
    // MARK: - Observers
    private func registerForKeyboardNotifications() {
        self.unregisterFromKeyboardNotifications()
    
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardWillShow(_:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    private func unregisterFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillShowNotification,
                                                  object: nil)
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillHideNotification,
                                                  object: nil)
    }
}

extension MTChangeBalanceViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.dismissKeyboard()
        return true
    }
}

extension MTChangeBalanceViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.category.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.category[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.categoryTextField.text = self.category[row]
        self.categoryTextField.resignFirstResponder()
    }
}
