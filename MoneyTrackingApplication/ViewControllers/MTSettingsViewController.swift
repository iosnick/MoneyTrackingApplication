//
//  MTSettingsViewController.swift
//  MoneyTrackingApplication
//
//  Created by Вадим Бенько on 07.02.2021.
//

import UIKit


class MTSettingsViewController: UIViewController {
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
        return imageView
    }()
    private lazy var tapToChangeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        button.backgroundColor = .clear
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Tap to Change", for: .normal)
        button.addTarget(self, action: #selector(self.openImagePicker), for: .touchUpInside)
        return button
    }()
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(red: 28/255, green: 26/255, blue: 38/255, alpha: 1)
        self.view.addSubviews([self.profileImageView, self.tapToChangeButton])
        
        let imageTap = UITapGestureRecognizer(target: self, action: #selector(self.openImagePicker))
        self.profileImageView.addGestureRecognizer(imageTap)
        
        self.imagePicker.delegate = self
        
        self.addConstraints()
    }
    
    // MARK: - Methods
    @objc private func openImagePicker() {
        self.present(self.imagePicker, animated: true, completion: nil)
    }
    
    // MARK: - Add constraints
    private func addConstraints() {
        var constraints = [NSLayoutConstraint]()
        
        // Add
        constraints.append(profileImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100))
        constraints.append(profileImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 137.5))
        constraints.append(profileImageView.widthAnchor.constraint(equalToConstant: 100))
        constraints.append(profileImageView.heightAnchor.constraint(equalToConstant: 100))
        
        constraints.append(tapToChangeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 210))
        constraints.append(tapToChangeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 127))
        constraints.append(tapToChangeButton.widthAnchor.constraint(equalToConstant: 120))
        constraints.append(tapToChangeButton.heightAnchor.constraint(equalToConstant: 20))
        
        // Activate (Applying)
        NSLayoutConstraint.activate(constraints)
    }
}

extension MTSettingsViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
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
