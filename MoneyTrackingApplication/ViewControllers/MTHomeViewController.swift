//
//  MTHomeViewController.swift
//  MoneyTrackingApplication
//
//  Created by Вадим Бенько on 05.02.2021.
//

import UIKit
import FirebaseAuth


class MTHomeViewController: UIViewController {
    // MARK: - Variables
    private let gradient: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor(red: 68/255, green: 71/255, blue: 234/255, alpha: 1).cgColor,
                           UIColor(red: 163/255, green: 90/255, blue: 255/255, alpha: 1).cgColor]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        return gradient
    }()
    // MARK: - GUI Variables
    private lazy var nameLabel: MTCustomLabel = {
        let label = MTCustomLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setLabelProperties(textColor: .white,
                                 text: "Welcome",
                                 textAlignment: .left,
                                 font: UIFont.boldSystemFont(ofSize: 31))
        return label
    }()
    private lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "defaultUserImage")
        imageView.layer.cornerRadius = 28
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    private lazy var cardView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 20
        return view
    }()
    private lazy var balanceLabel: MTCustomLabel = {
        let label = MTCustomLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setLabelProperties(textColor: .white, text: "Balance",
                                 textAlignment: .left, font: UIFont.boldSystemFont(ofSize: 17), lines: 1)
        return label
    }()
    private lazy var balanceLabelScore: MTCustomLabel = {
        let label = MTCustomLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setLabelProperties(textColor: .white, text: "$0",
                                 textAlignment: .left, font: UIFont.boldSystemFont(ofSize: 29), lines: 1)
        return label
    }()
    private lazy var incomeLabel: MTCustomLabel = {
        let label = MTCustomLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setLabelProperties(textColor: .white, text: "Income",
                                 textAlignment: .left, font: UIFont.boldSystemFont(ofSize: 17), lines: 1)
        return label
    }()
    private lazy var incomeLabelScore: MTCustomLabel = {
        let label = MTCustomLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setLabelProperties(textColor: .white, text: "+ $0",
                                 textAlignment: .left, font: UIFont.boldSystemFont(ofSize: 21), lines: 1)
        return label
    }()
    private lazy var outcomeLabel: MTCustomLabel = {
        let label = MTCustomLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setLabelProperties(textColor: .white, text: "Outcome",
                                 textAlignment: .left, font: UIFont.boldSystemFont(ofSize: 17), lines: 1)
        return label
    }()
    private lazy var outcomeLabelScore: MTCustomLabel = {
        let label = MTCustomLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setLabelProperties(textColor: .white, text: "- $0",
                                 textAlignment: .left, font: UIFont.boldSystemFont(ofSize: 21), lines: 1)
        return label
    }()
    
    // MARK: - Life cycle
//    override func loadView() {
//        super.loadView()
//
//                self.ref.child("users").child(Auth.auth().currentUser!.uid).observe(.value, with: { snapshot in
//            let userInfo = snapshot.value as? NSDictionary
//            let userName = userInfo!["name"] as! String
//            self.nameLabel.text = "Hello, \(userName)"
//        })
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(red: 24/255, green: 26/255, blue: 31/255, alpha: 1)
        self.view.addSubviews([self.nameLabel, self.profileImageView, self.cardView,
                               self.balanceLabel, self.balanceLabelScore, self.incomeLabel,
                               self.incomeLabelScore, self.outcomeLabel, self.outcomeLabelScore])
        
        self.addConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let userName = Auth.auth().currentUser?.displayName else { return }
        self.nameLabel.text = "Hello, \(userName)"
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.addGradientOnCard()
    }
    
    // MARK: - Methods
    private func addGradientOnCard() {
        self.gradient.frame = self.cardView.bounds
        self.gradient.cornerRadius = self.cardView.layer.cornerRadius
        self.cardView.layer.addSublayer(self.gradient)
    }
    // MARK: - Add constraints
    private func addConstraints() {
        var constraints = [NSLayoutConstraint]()
        
        // Add
        constraints.append(nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24))
        constraints.append(nameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 81))
        constraints.append(nameLabel.widthAnchor.constraint(equalToConstant: 270))
        constraints.append(nameLabel.heightAnchor.constraint(equalToConstant: 38))
        
        constraints.append(profileImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 72))
        constraints.append(profileImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 295))
        constraints.append(profileImageView.widthAnchor.constraint(equalToConstant: 56))
        constraints.append(profileImageView.heightAnchor.constraint(equalToConstant: 56))
        
        constraints.append(cardView.topAnchor.constraint(equalTo: view.topAnchor, constant: 169))
        constraints.append(cardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24))
        constraints.append(cardView.widthAnchor.constraint(equalToConstant: 327))
        constraints.append(cardView.heightAnchor.constraint(equalToConstant: 180))
        
        constraints.append(balanceLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 195))
        constraints.append(balanceLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50))
        constraints.append(balanceLabel.widthAnchor.constraint(equalToConstant: 68))
        constraints.append(balanceLabel.heightAnchor.constraint(equalToConstant: 20))
        
        constraints.append(balanceLabelScore.topAnchor.constraint(equalTo: view.topAnchor, constant: 220))
        constraints.append(balanceLabelScore.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50))
        constraints.append(balanceLabelScore.widthAnchor.constraint(equalToConstant: 200))
        constraints.append(balanceLabelScore.heightAnchor.constraint(equalToConstant: 35))
        
        constraints.append(incomeLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 271))
        constraints.append(incomeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50))
        constraints.append(incomeLabel.widthAnchor.constraint(equalToConstant: 64))
        constraints.append(incomeLabel.heightAnchor.constraint(equalToConstant: 20))
        
        constraints.append(incomeLabelScore.topAnchor.constraint(equalTo: view.topAnchor, constant: 298))
        constraints.append(incomeLabelScore.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50))
        constraints.append(incomeLabelScore.widthAnchor.constraint(equalToConstant: 115))
        constraints.append(incomeLabelScore.heightAnchor.constraint(equalToConstant: 26))
        
        constraints.append(outcomeLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 271))
        constraints.append(outcomeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 168))
        constraints.append(outcomeLabel.widthAnchor.constraint(equalToConstant: 80))
        constraints.append(outcomeLabel.heightAnchor.constraint(equalToConstant: 20))
        
        constraints.append(outcomeLabelScore.topAnchor.constraint(equalTo: view.topAnchor, constant: 298))
        constraints.append(outcomeLabelScore.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 168))
        constraints.append(outcomeLabelScore.widthAnchor.constraint(equalToConstant: 115))
        constraints.append(outcomeLabelScore.heightAnchor.constraint(equalToConstant: 26))
        
        // Activate (Applying)
        NSLayoutConstraint.activate(constraints)
    }
}
