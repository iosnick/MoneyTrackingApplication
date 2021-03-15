//
//  MTAddGoalViewController.swift
//  MoneyTrackingApplication
//
//  Created by Вадим Бенько on 10.03.2021.
//

import UIKit

class MTAddGoalViewController: UIViewController {
    // MARK: - GUI Variables
    private lazy var addNewGoal: MTCustomLabel = {
        let label = MTCustomLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setLabelProperties(textColor: .white, text: "Add new Goal",
                                 textAlignment: .center, font: UIFont.boldSystemFont(ofSize: 18), lines: 1)
        return label
    }()
    private lazy var viewWithLabelGoalTitle: UIView = {
        let view = UIView()
        let label = MTCustomLabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 24/255, green: 26/255, blue: 31/255, alpha: 1)
        label.setLabelProperties(textColor: UIColor(white: 1, alpha: 1),
                                 text: "Goal Title",
                                 textAlignment: .center,
                                 font: .boldSystemFont(ofSize: 11))
        label.frame = CGRect(x: 0, y: 0, width: 66, height: 16)
        view.addSubview(label)
        return view
    }()
    private lazy var goalTitleTextField: MTCustomTextField = {
        let textField = MTCustomTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.setTextFieldProperties(placeHolderText: "Enter goal title", cornerRadius: 15,
                                         borderColor: UIColor(red: 68.0/255.0, green: 71.0/255.0, blue: 234.0/255.0, alpha: 1.0).cgColor)
        textField.textContentType = .emailAddress
        let viewForText = UIView()
        viewForText.frame = CGRect(x: 0, y: 0, width: 17, height: 42)
        textField.addSubview(viewForText)
        textField.leftView = viewForText
        textField.leftViewMode = UITextField.ViewMode.always
        return textField
    }()
    private lazy var howMuchMoney: MTCustomLabel = {
        let label = MTCustomLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setLabelProperties(textColor: .white, text: "Required amount?",
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
    private lazy var currentMoney: MTCustomLabel = {
        let label = MTCustomLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setLabelProperties(textColor: .white, text: "Current sum?",
                                 textAlignment: .center, font: UIFont.systemFont(ofSize: 16), lines: 1)
        return label
    }()
    private lazy var enterMoneyCurrent: MTCustomTextField = {
        let textField = MTCustomTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.setTextFieldProperties(placeHolderText: "999999", textFont: UIFont.systemFont(ofSize: 16), cornerRadius: 15,
                                         borderColor: UIColor(red: 68.0/255.0, green: 71.0/255.0, blue: 234.0/255.0, alpha: 1.0).cgColor)
        textField.addLeftIconDollar()
        textField.keyboardType = .phonePad
        return textField
    }()
    private lazy var addButton: MTCustomButton = {
        let button = MTCustomButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setButtonProperties(title: "Add",
                                   cornerRadius: 20,
                                   titleColor: .white,
                                   backgroundColor: UIColor(red: 68.0/255.0, green: 71.0/255.0, blue: 234.0/255.0, alpha: 1.0))
        button.addTarget(self, action: #selector(self.addGoal), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(red: 27/255, green: 30/255, blue: 37/255, alpha: 1)
        self.view.addSubviews([self.addNewGoal, self.goalTitleTextField, self.viewWithLabelGoalTitle,
                               self.howMuchMoney, self.enterMoney, self.addButton,
                               self.currentMoney, self.enterMoneyCurrent])
        
        self.keyboardHideWhenTappedAround()
        self.addConstraints()
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
    
    // MARK: - Methods
    @objc private func addGoal() {
        if !self.goalTitleTextField.text!.isEmpty, !self.enterMoney.text!.isEmpty, !self.enterMoneyCurrent.text!.isEmpty {
            let goal = self.goalTitleTextField.text!
            let sum = Int64(self.enterMoney.text!)
            let currentSum = Int64(self.enterMoneyCurrent.text!)
            
            CoreDataManager.shared.writeDataInGoals(goal: goal, sum: sum!, currentSum: currentSum!)
            
            let vc = MTTabBarViewController()
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
        } else {
            self.showAlert()
        }
    }
    
    private func textFieldDelegate() {
        self.goalTitleTextField.delegate = self
        self.enterMoney.delegate = self
        self.enterMoneyCurrent.delegate = self
    }
    
    // MARK: - Alerts
    private func showAlert() {
        let alert = UIAlertController(title: "Oops!", message: "Goal title or required amount is empty!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .destructive, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Add constraints
    private func addConstraints() {
        var constraints = [NSLayoutConstraint]()
        
        // Add
        constraints.append(addNewGoal.topAnchor.constraint(equalTo: view.topAnchor, constant: 53))
        constraints.append(addNewGoal.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 122))
        constraints.append(addNewGoal.widthAnchor.constraint(equalToConstant: 130))
        constraints.append(addNewGoal.heightAnchor.constraint(equalToConstant: 22))
        
        constraints.append(goalTitleTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 38))
        constraints.append(goalTitleTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 100))
        constraints.append(goalTitleTextField.widthAnchor.constraint(equalToConstant: 300))
        constraints.append(goalTitleTextField.heightAnchor.constraint(equalToConstant: 42))
        
        constraints.append(viewWithLabelGoalTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 243))
        constraints.append(viewWithLabelGoalTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: 93))
        constraints.append(viewWithLabelGoalTitle.widthAnchor.constraint(equalToConstant: 66))
        constraints.append(viewWithLabelGoalTitle.heightAnchor.constraint(equalToConstant: 16))
        
        constraints.append(howMuchMoney.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50))
        constraints.append(howMuchMoney.topAnchor.constraint(equalTo: view.topAnchor, constant: 190))
        constraints.append(howMuchMoney.widthAnchor.constraint(equalToConstant: 277))
        constraints.append(howMuchMoney.heightAnchor.constraint(equalToConstant: 20))
        
        constraints.append(enterMoney.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 115))
        constraints.append(enterMoney.topAnchor.constraint(equalTo: view.topAnchor, constant: 218))
        constraints.append(enterMoney.widthAnchor.constraint(equalToConstant: 146))
        constraints.append(enterMoney.heightAnchor.constraint(equalToConstant: 32))
        
        constraints.append(currentMoney.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50))
        constraints.append(currentMoney.topAnchor.constraint(equalTo: view.topAnchor, constant: 270))
        constraints.append(currentMoney.widthAnchor.constraint(equalToConstant: 277))
        constraints.append(currentMoney.heightAnchor.constraint(equalToConstant: 20))
        
        constraints.append(enterMoneyCurrent.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 115))
        constraints.append(enterMoneyCurrent.topAnchor.constraint(equalTo: view.topAnchor, constant: 298))
        constraints.append(enterMoneyCurrent.widthAnchor.constraint(equalToConstant: 146))
        constraints.append(enterMoneyCurrent.heightAnchor.constraint(equalToConstant: 32))
        
        constraints.append(addButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 500))
        constraints.append(addButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 52))
        constraints.append(addButton.widthAnchor.constraint(equalToConstant: 272))
        constraints.append(addButton.heightAnchor.constraint(equalToConstant: 44))
  
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

extension MTAddGoalViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.dismissKeyboard()
        return true
    }
}
