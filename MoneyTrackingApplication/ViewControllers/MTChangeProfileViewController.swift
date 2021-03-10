//
//  MTChangeProfileViewController.swift
//  MoneyTrackingApplication
//
//  Created by Вадим Бенько on 09.02.2021.
//

import UIKit
import FirebaseDatabase
import FirebaseStorage
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
    private lazy var viewWithLabelName: UIView = {
        let view = UIView()
        let label = MTCustomLabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 24/255, green: 26/255, blue: 31/255, alpha: 1)
        label.setLabelProperties(textColor: UIColor(white: 1, alpha: 1),
                                 text: "Your Name",
                                 textAlignment: .center,
                                 font: .boldSystemFont(ofSize: 11))
        label.frame = CGRect(x: 0, y: 0, width: 79, height: 16)
        view.addSubview(label)
        return view
    }()
    private lazy var nameTextField: MTCustomTextField = {
        let textField = MTCustomTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.setTextFieldProperties(placeHolderText: String(Auth.auth().currentUser?.displayName ?? ""), cornerRadius: 15,
                                         borderColor: UIColor(red: 68.0/255.0, green: 71.0/255.0, blue: 234.0/255.0, alpha: 1.0).cgColor)
        textField.textContentType = .name
        let viewForText = UIView()
        viewForText.frame = CGRect(x: 0, y: 0, width: 17, height: 42)
        textField.addSubview(viewForText)
        textField.leftView = viewForText
        textField.leftViewMode = UITextField.ViewMode.always
        return textField
    }()
    private lazy var viewWithLabelEmail: UIView = {
        let view = UIView()
        let label = MTCustomLabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 24/255, green: 26/255, blue: 31/255, alpha: 1)
        label.setLabelProperties(textColor: UIColor(white: 1, alpha: 1),
                                 text: "Your Email",
                                 textAlignment: .center,
                                 font: .boldSystemFont(ofSize: 11))
        label.frame = CGRect(x: 0, y: 0, width: 79, height: 16)
        view.addSubview(label)
        return view
    }()
    private lazy var emailTextField: MTCustomTextField = {
        let textField = MTCustomTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.setTextFieldProperties(placeHolderText: String(Auth.auth().currentUser?.email ?? ""), cornerRadius: 15,
                                         borderColor: UIColor(red: 68.0/255.0, green: 71.0/255.0, blue: 234.0/255.0, alpha: 1.0).cgColor)
        textField.textContentType = .emailAddress
        let viewForText = UIView()
        viewForText.frame = CGRect(x: 0, y: 0, width: 17, height: 42)
        textField.addSubview(viewForText)
        textField.leftView = viewForText
        textField.leftViewMode = UITextField.ViewMode.always
        return textField
    }()
    private lazy var viewWithLabelGender: UIView = {
        let view = UIView()
        let label = MTCustomLabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 24/255, green: 26/255, blue: 31/255, alpha: 1)
        label.setLabelProperties(textColor: UIColor(white: 1, alpha: 1),
                                 text: "Gender",
                                 textAlignment: .center,
                                 font: .boldSystemFont(ofSize: 11))
        label.frame = CGRect(x: 0, y: 0, width: 60, height: 16)
        view.addSubview(label)
        return view
    }()
    private lazy var genderTextField: MTCustomTextField = {
        let textField = MTCustomTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.setTextFieldProperties(placeHolderText: "Select male", cornerRadius: 15,
                                         borderColor: UIColor(red: 68.0/255.0, green: 71.0/255.0, blue: 234.0/255.0, alpha: 1.0).cgColor)
        let viewForText = UIView()
        viewForText.frame = CGRect(x: 0, y: 0, width: 17, height: 42)
        textField.addSubview(viewForText)
        textField.leftView = viewForText
        textField.leftViewMode = UITextField.ViewMode.always
        return textField
    }()
    private lazy var viewWithLabelBirthOfDate: UIView = {
        let view = UIView()
        let label = MTCustomLabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 24/255, green: 26/255, blue: 31/255, alpha: 1)
        label.setLabelProperties(textColor: UIColor(white: 1, alpha: 1),
                                 text: "Date of Birth",
                                 textAlignment: .center,
                                 font: .boldSystemFont(ofSize: 11))
        label.frame = CGRect(x: 0, y: 0, width: 86, height: 16)
        view.addSubview(label)
        return view
    }()
    private lazy var dateOfBirthTextField: MTCustomTextField = {
        let textField = MTCustomTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.setTextFieldProperties(placeHolderText: "Select date of birth", cornerRadius: 15,
                                         borderColor: UIColor(red: 68.0/255.0, green: 71.0/255.0, blue: 234.0/255.0, alpha: 1.0).cgColor)
        let viewForText = UIView()
        viewForText.frame = CGRect(x: 0, y: 0, width: 17, height: 42)
        textField.addSubview(viewForText)
        textField.leftView = viewForText
        textField.leftViewMode = UITextField.ViewMode.always
        return textField
    }()
    private lazy var doneButton: MTCustomButton = {
        let button = MTCustomButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setButtonProperties(title: "Done",
                                   cornerRadius: 20,
                                   titleColor: .white,
                                   backgroundColor: UIColor(red: 68.0/255.0, green: 71.0/255.0, blue: 234.0/255.0, alpha: 1.0))
        button.addTarget(self, action: #selector(self.doneWasPressed), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(red: 24/255, green: 26/255, blue: 31/255, alpha: 1)
        self.view.addSubviews([self.profileImageView, self.nameTextField, self.viewWithLabelName,
                               self.emailTextField, self.viewWithLabelEmail, self.genderTextField,
                               self.viewWithLabelGender, self.dateOfBirthTextField, self.viewWithLabelBirthOfDate,
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
        
        self.addGradient()
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
    
    private func uploadProfileImage(_ image: UIImage, completion: ((_ url: URL) -> ())?) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let storageRef = Storage.storage().reference().child("user_\(uid)/file.png")
        
        guard let imageData = image.pngData() else { return }
        storageRef.putData(imageData, metadata: nil) { _, error in
            guard error == nil else { return }
            storageRef.downloadURL(completion: { url, error in
//                guard let url = url, error == nil else { return }
//                let urlString = url.absoluteString
            })
            
        }
    }
    
//    private func saveProfile(username: String, profileImageURL: URL, completion: @escaping ((_ success: Bool) -> ())) {
//        guard let uid = Auth.auth().currentUser?.uid else { return }
//        let dateBaseRef = Database.database().reference().child("users...\(uid)...profileImage/file.png")
//
//        let userObject = [
//            "username": username,
//            "photoURL": profileImageURL.absoluteString
//        ] as [String: Any]
//
//        dateBaseRef.setValue(userObject) { (error, ref) in
//            completion(error == nil)
//        }
//    }
    
    private func textFieldDelegate() {
        self.nameTextField.delegate = self
        self.emailTextField.delegate = self
        self.imagePicker.delegate = self
        self.genderTextField.delegate = self
    }
    
    private func addGradient() {
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
    
    @objc private func doneWasPressed() {
        guard let _ = Auth.auth().currentUser?.uid else { return }
        if let image = self.profileImageView.image {
            if let name = self.nameTextField.text {
                let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                changeRequest?.displayName = name
                changeRequest?.commitChanges(completion: nil)
                
                self.uploadProfileImage(image, completion: nil)
                self.navigationController?.popViewController(animated: false)
            } else {
                self.uploadProfileImage(image, completion: nil)
                self.navigationController?.popViewController(animated: false)
            }
        } else {
            self.navigationController?.popViewController(animated: false)
        }
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
        
        constraints.append(nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 38))
        constraints.append(nameTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 245))
        constraints.append(nameTextField.widthAnchor.constraint(equalToConstant: 300))
        constraints.append(nameTextField.heightAnchor.constraint(equalToConstant: 42))
        
        constraints.append(viewWithLabelName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 240))
        constraints.append(viewWithLabelName.topAnchor.constraint(equalTo: view.topAnchor, constant: 238))
        constraints.append(viewWithLabelName.widthAnchor.constraint(equalToConstant: 79))
        constraints.append(viewWithLabelName.heightAnchor.constraint(equalToConstant: 16))
        
        constraints.append(emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 38))
        constraints.append(emailTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 322))
        constraints.append(emailTextField.widthAnchor.constraint(equalToConstant: 300))
        constraints.append(emailTextField.heightAnchor.constraint(equalToConstant: 42))
        
        constraints.append(viewWithLabelEmail.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 240))
        constraints.append(viewWithLabelEmail.topAnchor.constraint(equalTo: view.topAnchor, constant: 315))
        constraints.append(viewWithLabelEmail.widthAnchor.constraint(equalToConstant: 79))
        constraints.append(viewWithLabelEmail.heightAnchor.constraint(equalToConstant: 16))
        
        constraints.append(genderTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 38))
        constraints.append(genderTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 399))
        constraints.append(genderTextField.widthAnchor.constraint(equalToConstant: 300))
        constraints.append(genderTextField.heightAnchor.constraint(equalToConstant: 42))
        
        constraints.append(viewWithLabelGender.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 250))
        constraints.append(viewWithLabelGender.topAnchor.constraint(equalTo: view.topAnchor, constant: 392))
        constraints.append(viewWithLabelGender.widthAnchor.constraint(equalToConstant: 60))
        constraints.append(viewWithLabelGender.heightAnchor.constraint(equalToConstant: 16))
        
        constraints.append(dateOfBirthTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 38))
        constraints.append(dateOfBirthTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 476))
        constraints.append(dateOfBirthTextField.widthAnchor.constraint(equalToConstant: 300))
        constraints.append(dateOfBirthTextField.heightAnchor.constraint(equalToConstant: 42))
        
        constraints.append(viewWithLabelBirthOfDate.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 237))
        constraints.append(viewWithLabelBirthOfDate.topAnchor.constraint(equalTo: view.topAnchor, constant: 469))
        constraints.append(viewWithLabelBirthOfDate.widthAnchor.constraint(equalToConstant: 86))
        constraints.append(viewWithLabelBirthOfDate.heightAnchor.constraint(equalToConstant: 16))
        
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
