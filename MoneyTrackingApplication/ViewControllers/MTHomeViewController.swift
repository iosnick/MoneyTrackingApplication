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
    private var goalsCount = CoreDataManager.shared.readGoalsCount()
    
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
        label.setLabelProperties(textColor: .white, text: "",
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
    private lazy var segmentedControl: UISegmentedControl = {
        let items = ["Goals", "History"]
        
        let control = UISegmentedControl(items: items)
        control.selectedSegmentIndex = 0
        control.addTarget(self, action: #selector(self.didChangeSegment(_:)), for: .valueChanged)
        control.translatesAutoresizingMaskIntoConstraints = false
        control.selectedSegmentTintColor = UIColor(red: 136/255, green: 134/255, blue: 251/255, alpha: 1)
        control.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white,
                                        NSAttributedString.Key.font: UIFont.systemFont(ofSize: 19)], for: .normal)
        return control
    }()
    private lazy var viewGoals: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var addButton: UIButton = {
        let button = UIButton()
        button.setTitle("Add goal to list", for: .normal)
        button.backgroundColor = UIColor(red: 39/255, green: 42/255, blue: 51/255, alpha: 1)
        button.layer.cornerRadius = 20
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.addTarget(self, action: #selector(self.addGoal), for: .touchUpInside)
        
        let imageView = UIImageView()
        imageView.image = UIImage(named: "addIcon")
        imageView.frame = .init(x: 30, y: 15, width: 40, height: 40)
        
        button.addSubview(imageView)
        return button
    }()
    private lazy var firstGoal: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 20
        view.backgroundColor = UIColor(red: 39/255, green: 42/255, blue: 51/255, alpha: 1)
        return view
    }()
    private lazy var secondGoal: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 20
        view.backgroundColor = UIColor(red: 39/255, green: 42/255, blue: 51/255, alpha: 1)
        return view
    }()
    private lazy var thirdGoal: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 20
        view.backgroundColor = UIColor(red: 39/255, green: 42/255, blue: 51/255, alpha: 1)
        return view
    }()
    private lazy var viewHistory: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 24/255, green: 26/255, blue: 31/255, alpha: 1)
        view.isHidden = true
        return view
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
                               self.incomeLabelScore, self.outcomeLabel, self.outcomeLabelScore,
                               self.segmentedControl, self.viewGoals, self.viewHistory])
        
        self.viewGoals.addSubviews([self.addButton, self.firstGoal, self.secondGoal, self.thirdGoal])
        self.addConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let userName = Auth.auth().currentUser?.displayName else { return }
        self.nameLabel.text = "Hello, \(userName)"
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.createHistoryList()
        self.addButtonChangeFrame()
        self.addGradientOnCard()
        self.setCardValue()
        
        if goalsCount != 0 {
            self.setGoalsViews()
        }
    }
    
    // MARK: - Methods
    @objc private func addGoal() {
        let vc = MTAddGoalViewController()
        vc.title = "Add new Goal"
        self.present(vc, animated: true, completion: nil)
    }
    
    @objc private func didChangeSegment(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            self.viewHistory.isHidden = true
            self.viewGoals.isHidden = false
        } else if sender.selectedSegmentIndex == 1 {
            self.viewGoals.isHidden = true
            self.viewHistory.isHidden = false
        }
    }
    
    private func createHistoryList() {
        let array = CoreDataManager.shared.readCategory()
        var count = 0
        let topAnchor = 87
        for items in array.enumerated() {
            let view = UIView()
            view.layer.cornerRadius = 20
            view.backgroundColor = UIColor(red: 39/255, green: 42/255, blue: 51/255, alpha: 1)
            view.layer.borderWidth = 1
            
            if items.element.2 == true {
                view.layer.borderColor = UIColor(red: 0/255, green: 255/255, blue: 117/255, alpha: 1).cgColor
            } else {
                view.layer.borderColor = UIColor(red: 248/255, green: 103/255, blue: 103/255, alpha: 1).cgColor
            }
            
            view.frame = .init(x: 0, y: (count * topAnchor), width: 327, height: 70)
            count += 1
            
            let label = UILabel()
            label.textColor = .white
            label.font = UIFont.boldSystemFont(ofSize: 17)
            label.text = items.element.0
            label.textAlignment = .center
            label.frame = .init(x: 101, y: 20, width: 125, height: 30)
            
            let image = UIImageView()
            image.frame = .init(x: 30, y: 15, width: 40, height: 40)
            
            if items.element.0.hasPrefix("Food") {
                image.image = UIImage(named: "food")
            } else if items.element.0.hasPrefix("Salary") {
                image.image = UIImage(named: "salary")
            } else if items.element.0.hasPrefix("Car") {
                image.image = UIImage(named: "car")
            } else if items.element.0.hasPrefix("Entertainments") {
                image.image = UIImage(named: "razvl")
            } else if items.element.0.hasPrefix("Other") {
                image.image = UIImage(named: "other")
            }
            
            view.addSubviews([label, image])
            self.viewHistory.addSubviews([view])
        }
    }
    
    private func addButtonChangeFrame() {
        switch self.goalsCount {
        case 0:
            self.addButton.frame = .init(x: 0, y: 0, width: 327, height: 70)
        case 1:
            self.firstGoal.frame = .init(x: 0, y: 0, width: 327, height: 70)
            self.addButton.frame = .init(x: 0, y: 87, width: 327, height: 70)
        case 2:
            self.firstGoal.frame = .init(x: 0, y: 0, width: 327, height: 70)
            self.secondGoal.frame = .init(x: 0, y: 87, width: 327, height: 70)
            self.addButton.frame = .init(x: 0, y: 174, width: 327, height: 70)
        case 3:
            self.firstGoal.frame = .init(x: 0, y: 0, width: 327, height: 70)
            self.secondGoal.frame = .init(x: 0, y: 87, width: 327, height: 70)
            self.thirdGoal.frame = .init(x: 0, y: 174, width: 327, height: 70)
        default:
            break
        }
    }
    
    private func setGoalsViews() {
        let goalResult = CoreDataManager.shared.readGoals()
        
        var firstGoalLevel: Int64 = 0
        var secondGoalLevel: Int64 = 0
        var thirdGoalLevel: Int64 = 0
        
        let labelToFirst = UILabel()
        labelToFirst.frame = .init(x: 100, y: 20, width: 125, height: 30)
        labelToFirst.textAlignment = .left
        labelToFirst.textColor = .white
        labelToFirst.font = UIFont.boldSystemFont(ofSize: 17)
        
        let labelLevelToFirst = UILabel()
        labelLevelToFirst.frame = .init(x: 260, y: 20, width: 50, height: 30)
        labelLevelToFirst.textAlignment = .left
        labelLevelToFirst.textColor = .white
        labelLevelToFirst.font = UIFont.boldSystemFont(ofSize: 17)
        
        let progressViewFirst = UIProgressView(progressViewStyle: .bar)
        progressViewFirst.trackTintColor = UIColor(red: 255/255, green: 245/255, blue: 0/255, alpha: 0.25)
        progressViewFirst.progressTintColor = UIColor(red: 255/255, green: 245/255, blue: 0/255, alpha: 1)
        progressViewFirst.frame = .init(x: 15, y: 67, width: 296, height: 2)
        
        let imageFirst = UIImageView()
        imageFirst.image = UIImage(named: "goalFirst")
        imageFirst.frame = .init(x: 30, y: 15, width: 40, height: 40)
        
        let labelToSecond = UILabel()
        labelToSecond.frame = .init(x: 100, y: 20, width: 125, height: 30)
        labelToSecond.textAlignment = .left
        labelToSecond.textColor = .white
        labelToSecond.font = UIFont.boldSystemFont(ofSize: 17)
        
        let labelLevelToSecond = UILabel()
        labelLevelToSecond.frame = .init(x: 260, y: 20, width: 50, height: 30)
        labelLevelToSecond.textAlignment = .left
        labelLevelToSecond.textColor = .white
        labelLevelToSecond.font = UIFont.boldSystemFont(ofSize: 17)
        
        let progressViewSecond = UIProgressView(progressViewStyle: .bar)
        progressViewSecond.trackTintColor = UIColor(red: 255/255, green: 0/255, blue: 184/255, alpha: 0.25)
        progressViewSecond.progressTintColor = UIColor(red: 255/255, green: 0/255, blue: 184/255, alpha: 1)
        progressViewSecond.frame = .init(x: 15, y: 67, width: 296, height: 2)
        
        let imageSecond = UIImageView()
        imageSecond.image = UIImage(named: "goalSecond")
        imageSecond.frame = .init(x: 30, y: 15, width: 40, height: 40)
        
        let labelToThird = UILabel()
        labelToThird.frame = .init(x: 100, y: 20, width: 125, height: 30)
        labelToThird.textAlignment = .left
        labelToThird.textColor = .white
        labelToThird.font = UIFont.boldSystemFont(ofSize: 17)
        
        let labelLevelToThird = UILabel()
        labelLevelToThird.frame = .init(x: 260, y: 20, width: 50, height: 30)
        labelLevelToThird.textAlignment = .left
        labelLevelToThird.textColor = .white
        labelLevelToThird.font = UIFont.boldSystemFont(ofSize: 17)
        
        let progressViewThird = UIProgressView(progressViewStyle: .bar)
        progressViewThird.trackTintColor = UIColor(red: 66/255, green: 255/255, blue: 0/255, alpha: 0.25)
        progressViewThird.progressTintColor = UIColor(red: 66/255, green: 255/255, blue: 0/255, alpha: 1)
        progressViewThird.frame = .init(x: 15, y: 67, width: 296, height: 2)
        
        let imageThird = UIImageView()
        imageThird.image = UIImage(named: "goalThird")
        imageThird.frame = .init(x: 30, y: 15, width: 40, height: 40)
        
        if self.goalsCount == 1 {
            firstGoalLevel = ((100 * goalResult[0].2) / goalResult[0].1)
            labelToFirst.text = goalResult[0].0
        } else if self.goalsCount == 2 {
            firstGoalLevel = ((100 * goalResult[0].2) / goalResult[0].1)
            labelToFirst.text = goalResult[0].0
            secondGoalLevel = ((100 * goalResult[1].2) / goalResult[1].1)
            labelToSecond.text = goalResult[1].0
        } else if self.goalsCount == 3 {
            firstGoalLevel = ((100 * goalResult[0].2) / goalResult[0].1)
            labelToFirst.text = goalResult[0].0
            secondGoalLevel = ((100 * goalResult[1].2) / goalResult[1].1)
            labelToSecond.text = goalResult[1].0
            thirdGoalLevel = ((100 * goalResult[2].2) / goalResult[2].1)
            labelToThird.text = goalResult[2].0
        }
        
        labelLevelToFirst.text = "\(firstGoalLevel)%"
        labelLevelToSecond.text = "\(secondGoalLevel)%"
        labelLevelToThird.text = "\(thirdGoalLevel)%"
        progressViewFirst.setProgress(Float(firstGoalLevel) / 100, animated: true)
        progressViewSecond.setProgress(Float(secondGoalLevel) / 100, animated: true)
        progressViewThird.setProgress(Float(thirdGoalLevel) / 100, animated: true)
        
        
        
        switch goalResult.count {
        case 1:
            self.firstGoal.addSubviews([labelToFirst, imageFirst, labelLevelToFirst, progressViewFirst])
        case 2:
            self.firstGoal.addSubviews([labelToFirst, imageFirst, labelLevelToFirst, progressViewFirst])
            self.secondGoal.addSubviews([labelToSecond, imageSecond, labelLevelToSecond, progressViewSecond])
        case 3:
            self.firstGoal.addSubviews([labelToFirst, imageFirst, labelLevelToFirst, progressViewFirst])
            self.secondGoal.addSubviews([labelToSecond, imageSecond, labelLevelToSecond, progressViewSecond])
            self.thirdGoal.addSubviews([labelToThird, imageThird, labelLevelToThird, progressViewThird])
        default:
            break
        }

       
        
    }
    
    private func setCardValue() {
        let resultArray = CoreDataManager.shared.readBalance()

        self.balanceLabelScore.text = String("$\(resultArray[0])")
        self.incomeLabelScore.text = String("+ $\(resultArray[1])")
        self.outcomeLabelScore.text = String("- $\(resultArray[2])")
    }
    
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
        
        constraints.append(segmentedControl.topAnchor.constraint(equalTo: view.topAnchor, constant: 386))
        constraints.append(segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24))
        constraints.append(segmentedControl.widthAnchor.constraint(equalToConstant: 327))
        constraints.append(segmentedControl.heightAnchor.constraint(equalToConstant: 38))
        
        constraints.append(viewGoals.topAnchor.constraint(equalTo: view.topAnchor, constant: 452))
        constraints.append(viewGoals.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24))
        constraints.append(viewGoals.widthAnchor.constraint(equalToConstant: 327))
        constraints.append(viewGoals.heightAnchor.constraint(equalToConstant: 244))
        
        constraints.append(viewHistory.topAnchor.constraint(equalTo: view.topAnchor, constant: 452))
        constraints.append(viewHistory.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24))
        constraints.append(viewHistory.widthAnchor.constraint(equalToConstant: 327))
        constraints.append(viewHistory.heightAnchor.constraint(equalToConstant: 1000))
        
        // Activate (Applying)
        NSLayoutConstraint.activate(constraints)
    }
}
