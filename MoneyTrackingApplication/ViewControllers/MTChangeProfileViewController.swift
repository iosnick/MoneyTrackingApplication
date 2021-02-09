//
//  MTChangeProfileViewController.swift
//  MoneyTrackingApplication
//
//  Created by Вадим Бенько on 09.02.2021.
//

import UIKit
import FirebaseAuth

class MTChangeProfileViewController: UIViewController {
    // MARK: - Variables
    private let male = ["Not defined", "Man", "Women"]
    private let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        return datePicker
    }()
    private var imagePicker: UIImagePickerController = {
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        return imagePicker
    }()
    
    // MARK: - GUI Variables
    private lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.isUserInteractionEnabled = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "defaultUserImage")
        imageView.layer.cornerRadius = 50
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        
        let view = UIView()
        view.clipsToBounds = true
        view.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        view.backgroundColor = UIColor(red: 19/255, green: 96/255, blue: 255/255, alpha: 0.7)
        
        let button = UIButton()
        button.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        button.setImage(UIImage(named: "cameraIcon"), for: .normal)
        button.addTarget(self, action: #selector(self.openImagePicker), for: .touchUpInside)
        
        imageView.addSubviews([view, button])
        return imageView
    }()
    private lazy var nameLabel: MTCustomLabel = {
        let label = MTCustomLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setLabelProperties(textColor: UIColor(white: 1, alpha: 1),
                                 text: "Your Name",
                                 textAlignment: .left,
                                 font: .boldSystemFont(ofSize: 18))
        return label
    }()
    private lazy var nameTextField: MTCustomTextField = {
        let textField = MTCustomTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.setTextFieldProperties(placeHolderText: String(Auth.auth().currentUser?.displayName ?? ""))
        textField.textContentType = .name
        return textField
    }()
    private lazy var emailLabel: MTCustomLabel = {
        let label = MTCustomLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setLabelProperties(textColor: UIColor(white: 1, alpha: 1),
                                 text: "Your Email",
                                 textAlignment: .left,
                                 font: .boldSystemFont(ofSize: 18))
        return label
    }()
    private lazy var emailTextField: MTCustomTextField = {
        let textField = MTCustomTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.setTextFieldProperties(placeHolderText: String(Auth.auth().currentUser?.email ?? ""))
        textField.textContentType = .emailAddress
        return textField
    }()
    private lazy var genderLabel: MTCustomLabel = {
        let label = MTCustomLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setLabelProperties(textColor: UIColor(white: 1, alpha: 1),
                                 text: "Gender",
                                 textAlignment: .left,
                                 font: .boldSystemFont(ofSize: 18))
        return label
    }()
    private lazy var genderTextField: MTCustomTextField = {
        let textField = MTCustomTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.setTextFieldProperties(placeHolderText: "Select male")
        return textField
    }()
    private lazy var dateOfBirthLabel: MTCustomLabel = {
        let label = MTCustomLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setLabelProperties(textColor: UIColor(white: 1, alpha: 1),
                                 text: "Date of Birth",
                                 textAlignment: .left,
                                 font: .boldSystemFont(ofSize: 18))
        return label
    }()
    private lazy var dateOfBirthTextField: MTCustomTextField = {
        let textField = MTCustomTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.setTextFieldProperties(placeHolderText: "Select date of birth")
        return textField
    }()
    private lazy var doneButton: MTSignInUpButton = {
        let button = MTSignInUpButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setButtonProperties(title: "Done",
                                   cornerRadius: 25,
                                   titleColor: .white,
                                   backgroundColor: UIColor(red: 68.0/255.0, green: 71.0/255.0, blue: 234.0/255.0, alpha: 1.0))
//        button.addTarget(self, action: #selector(self.), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(red: 28/255, green: 26/255, blue: 38/255, alpha: 1)
        self.view.addSubviews([self.profileImageView, self.nameLabel, self.nameTextField,
                               self.emailLabel, self.emailTextField, self.genderLabel,
                               self.genderTextField, self.dateOfBirthLabel, self.dateOfBirthTextField,
                               self.doneButton])
        
        self.textFieldDelegate()
        self.addPrickerViewAndDatePicker()
        self.keyboardHideWhenTappedAround()
        self.setupNavigationBarProperties()
        self.addConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tabBarController?.tabBar.isTranslucent = true
        self.tabBarController?.tabBar.isHidden = true
        
        self.registerForKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.tabBarController?.tabBar.isTranslucent = false
        self.tabBarController?.tabBar.isHidden = false
        
        self.unregisterFromKeyboardNotifications()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.setupBorderLinesAddGradient()
    }
    
    
    // MARK: - Methods
    private func addPrickerViewAndDatePicker() {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.setDate))
        toolBar.setItems([doneButton], animated: true)
        
        self.dateOfBirthTextField.inputAccessoryView = toolBar
        self.dateOfBirthTextField.inputView = self.datePicker
        self.genderTextField.inputView = pickerView
    }
    
    private func uploadProfileImage(_ image: UIImage, completion: @escaping ((_ url: String) -> ())) {
//        guard let uid = Auth.auth().currentUser?.uid else { return }
//        let storageRef = Storage.storage().reference().child("user/\(uid)")
    }
    
    private func textFieldDelegate() {
        self.nameTextField.delegate = self
        self.emailTextField.delegate = self
        self.imagePicker.delegate = self
        self.genderTextField.delegate = self
    }
    
    private func setupBorderLinesAddGradient() {
        self.nameTextField.addBottomBorder(width: self.nameTextField.frame.width,
                                                heidth: self.nameTextField.frame.height)
        self.emailTextField.addBottomBorder(width: self.emailTextField.frame.width,
                                                   heidth: self.emailTextField.frame.height)
        self.genderTextField.addBottomBorder(width: self.genderTextField.frame.width,
                                                   heidth: self.genderTextField.frame.height)
        self.dateOfBirthTextField.addBottomBorder(width: self.dateOfBirthTextField.frame.width,
                                                   heidth: self.dateOfBirthTextField.frame.height)
        self.doneButton.setupGradient(buttonCornerRadius: self.doneButton.layer.cornerRadius, bounds: self.doneButton.bounds)
    }
    
    private func setupNavigationBarProperties() {
        self.title = "Edit Profile"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationController?.setToolbarHidden(true, animated: true)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "backArrow"),
                                                                style: .plain, target: self,
                                                                action: #selector(self.backTaped))
    }
    
    @objc private func setDate() {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        
        self.dateOfBirthTextField.text = formatter.string(from: self.datePicker.date)
        self.view.endEditing(true)
    }
    
    @objc private func backTaped() {
        self.navigationController?.popViewController(animated: false)
    }
    
    @objc private func openImagePicker() {
        self.present(self.imagePicker, animated: true, completion: nil)
    }
    
    // MARK: - Add constraints
    private func addConstraints() {
        var constraints = [NSLayoutConstraint]()
        
        // Add
        constraints.append(profileImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 96))
        constraints.append(profileImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 138))
        constraints.append(profileImageView.widthAnchor.constraint(equalToConstant: 100))
        constraints.append(profileImageView.heightAnchor.constraint(equalToConstant: 100))
        
        constraints.append(nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 38))
        constraints.append(nameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 230))
        constraints.append(nameLabel.widthAnchor.constraint(equalToConstant: 103))
        constraints.append(nameLabel.heightAnchor.constraint(equalToConstant: 22))
        
        constraints.append(nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 38))
        constraints.append(nameTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 256))
        constraints.append(nameTextField.widthAnchor.constraint(equalToConstant: 300))
        constraints.append(nameTextField.heightAnchor.constraint(equalToConstant: 26))
        
        constraints.append(emailLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 38))
        constraints.append(emailLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 323))
        constraints.append(emailLabel.widthAnchor.constraint(equalToConstant: 100))
        constraints.append(emailLabel.heightAnchor.constraint(equalToConstant: 22))
        
        constraints.append(emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 38))
        constraints.append(emailTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 349))
        constraints.append(emailTextField.widthAnchor.constraint(equalToConstant: 300))
        constraints.append(emailTextField.heightAnchor.constraint(equalToConstant: 22))
        
        constraints.append(genderLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 38))
        constraints.append(genderLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 416))
        constraints.append(genderLabel.widthAnchor.constraint(equalToConstant: 69))
        constraints.append(genderLabel.heightAnchor.constraint(equalToConstant: 22))
        
        constraints.append(genderTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 38))
        constraints.append(genderTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 442))
        constraints.append(genderTextField.widthAnchor.constraint(equalToConstant: 300))
        constraints.append(genderTextField.heightAnchor.constraint(equalToConstant: 22))
        
        constraints.append(dateOfBirthLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 38))
        constraints.append(dateOfBirthLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 509))
        constraints.append(dateOfBirthLabel.widthAnchor.constraint(equalToConstant: 120))
        constraints.append(dateOfBirthLabel.heightAnchor.constraint(equalToConstant: 22))
        
        constraints.append(dateOfBirthTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 38))
        constraints.append(dateOfBirthTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 535))
        constraints.append(dateOfBirthTextField.widthAnchor.constraint(equalToConstant: 300))
        constraints.append(dateOfBirthTextField.heightAnchor.constraint(equalToConstant: 22))
        
        constraints.append(doneButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 80))
        constraints.append(doneButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -80))
        constraints.append(doneButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 607))
        constraints.append(doneButton.heightAnchor.constraint(equalToConstant: 44))
        
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


extension MTChangeProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else { return }
        self.profileImageView.image = image
    }
}

extension MTChangeProfileViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.dismissKeyboard()
        return true
    }
}

extension MTChangeProfileViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.male.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.male[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.genderTextField.text = self.male[row]
        self.genderTextField.resignFirstResponder()
    }
}
