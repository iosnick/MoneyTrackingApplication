//
//  MTChangeProfileViewController.swift
//  MoneyTrackingApplication
//
//  Created by Вадим Бенько on 09.02.2021.
//

import UIKit

class MTChangeProfileViewController: UIViewController {
    // MARK: - Variables
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
    private lazy var nameLabel: MTCustomLabel = {
        let label = MTCustomLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setLabelProperties(textColor: UIColor(white: 1, alpha: 0.75),
                                 text: "Your Name",
                                 textAlignment: .left,
                                 font: .boldSystemFont(ofSize: 18))
        return label
    }()
    private lazy var emailLabel: MTCustomLabel = {
        let label = MTCustomLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setLabelProperties(textColor: UIColor(white: 1, alpha: 0.75),
                                 text: "Your Email",
                                 textAlignment: .left,
                                 font: .boldSystemFont(ofSize: 18))
        return label
    }()
    private lazy var genderLabel: MTCustomLabel = {
        let label = MTCustomLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setLabelProperties(textColor: UIColor(white: 1, alpha: 0.75),
                                 text: "Gender",
                                 textAlignment: .left,
                                 font: .boldSystemFont(ofSize: 18))
        return label
    }()
    private lazy var dateOfBirthLabel: MTCustomLabel = {
        let label = MTCustomLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setLabelProperties(textColor: UIColor(white: 1, alpha: 0.75),
                                 text: "Date of Birth",
                                 textAlignment: .left,
                                 font: .boldSystemFont(ofSize: 18))
        return label
    }()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(red: 28/255, green: 26/255, blue: 38/255, alpha: 1)
        self.view.addSubviews([self.profileImageView, self.dateOfBirthLabel, self.doneButton,
                               self.nameLabel, self.emailLabel, self.genderLabel])
        
        self.imagePicker.delegate = self
        
        self.setupNavigationBarProperties()
        self.addConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tabBarController?.tabBar.isTranslucent = true
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.tabBarController?.tabBar.isTranslucent = false
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.setupBorderLinesAddGradient()
    }
    
    // MARK: - Methods
    private func uploadProfileImage(_ image: UIImage, completion: @escaping ((_ url: String) -> ())) {
//        guard let uid = Auth.auth().currentUser?.uid else { return }
//        let storageRef = Storage.storage().reference().child("user/\(uid)")
    }
    
    private func setupBorderLinesAddGradient() {
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
        
        constraints.append(doneButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 80))
        constraints.append(doneButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -80))
        constraints.append(doneButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 607))
        constraints.append(doneButton.heightAnchor.constraint(equalToConstant: 44))
        
        constraints.append(nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 38))
        constraints.append(nameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 230))
        constraints.append(nameLabel.widthAnchor.constraint(equalToConstant: 103))
        constraints.append(nameLabel.heightAnchor.constraint(equalToConstant: 22))
        
        constraints.append(emailLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 38))
        constraints.append(emailLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 323))
        constraints.append(emailLabel.widthAnchor.constraint(equalToConstant: 100))
        constraints.append(emailLabel.heightAnchor.constraint(equalToConstant: 22))
        
        constraints.append(genderLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 38))
        constraints.append(genderLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 416))
        constraints.append(genderLabel.widthAnchor.constraint(equalToConstant: 69))
        constraints.append(genderLabel.heightAnchor.constraint(equalToConstant: 22))
        
        constraints.append(dateOfBirthLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 38))
        constraints.append(dateOfBirthLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 509))
        constraints.append(dateOfBirthLabel.widthAnchor.constraint(equalToConstant: 120))
        constraints.append(dateOfBirthLabel.heightAnchor.constraint(equalToConstant: 22))
        
        // Activate (Applying)
        NSLayoutConstraint.activate(constraints)
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
