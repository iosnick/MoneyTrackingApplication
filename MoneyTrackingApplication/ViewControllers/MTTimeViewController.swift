//
//  MTTimeViewController.swift
//  MoneyTrackingApplication
//
//  Created by Вадим Бенько on 07.02.2021.
//

import UIKit
import Charts

class MTTimeViewController: UIViewController {
    // MARK: - Variables
    
    
    // MARK: - GUI Variables
    private lazy var labelCosts: MTCustomLabel = {
        let label = MTCustomLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setLabelProperties(textColor: .white, text: "Costs",
                                 textAlignment: .center, font: UIFont.boldSystemFont(ofSize: 18), lines: 1)
        return label
    }()
    private lazy var viewCustom: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 20
        view.backgroundColor = UIColor(red: 39/255, green: 42/255, blue: 51/255, alpha: 1)
        return view
    }()
    private lazy var pieChart: PieChartView = {
        let chart = PieChartView()
        chart.translatesAutoresizingMaskIntoConstraints = false
        return chart
    }()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(red: 24/255, green: 26/255, blue: 31/255, alpha: 1)
        self.view.addSubviews([self.labelCosts, self.viewCustom, self.pieChart])
        
        self.setPieChartProperties()
        self.addConstraints()
    }
    
    // MARK: - Methods
    private func setPieChartProperties() {
        let resultCosts = CoreDataManager.shared.readCategory()
        guard resultCosts.count >= 5 else { return }
        
        let allCostsValue = resultCosts[0].1 + resultCosts[1].1 + resultCosts[2].1 + resultCosts[3].1 + resultCosts[4].1
        
        var nummberOfDownloadsDataEntries = [PieChartDataEntry]()
        let firstDataEntry = PieChartDataEntry(value: (Double(resultCosts[0].1) * 100 / Double(allCostsValue)))
        firstDataEntry.label = resultCosts[0].0
        let secondDataEntry = PieChartDataEntry(value: (Double(resultCosts[1].1) * 100 / Double(allCostsValue)))
        secondDataEntry.label = resultCosts[1].0
        let thirdDataEntry = PieChartDataEntry(value: (Double(resultCosts[2].1) * 100 / Double(allCostsValue)))
        thirdDataEntry.label = resultCosts[2].0
        let fourthDataEntry = PieChartDataEntry(value: (Double(resultCosts[3].1) * 100 / Double(allCostsValue)))
        fourthDataEntry.label = resultCosts[3].0
        let fiveDataEntry = PieChartDataEntry(value: (Double(resultCosts[4].1) * 100 / Double(allCostsValue)))
        fiveDataEntry.label = resultCosts[4].0
        
        nummberOfDownloadsDataEntries = [firstDataEntry, secondDataEntry, thirdDataEntry, fourthDataEntry, fiveDataEntry]
        
        let chartDataSet = PieChartDataSet(entries: nummberOfDownloadsDataEntries, label: nil)
        let chartData = PieChartData(dataSet: chartDataSet)
        
        let colors = [UIColor.red, UIColor.green, UIColor.blue, UIColor.orange, UIColor.purple]
        chartDataSet.colors = colors
        
        pieChart.data = chartData
    }
    
    // MARK: - Add constraints
    private func addConstraints() {
        var constraints = [NSLayoutConstraint]()
        
        // Add
        constraints.append(labelCosts.topAnchor.constraint(equalTo: view.topAnchor, constant: 63))
        constraints.append(labelCosts.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 162))
        constraints.append(labelCosts.widthAnchor.constraint(equalToConstant: 51))
        constraints.append(labelCosts.heightAnchor.constraint(equalToConstant: 22))
        
        constraints.append(viewCustom.topAnchor.constraint(equalTo: view.topAnchor, constant: 106))
        constraints.append(viewCustom.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15))
        constraints.append(viewCustom.widthAnchor.constraint(equalToConstant: 345))
        constraints.append(viewCustom.heightAnchor.constraint(equalToConstant: 363))
        
        constraints.append(pieChart.topAnchor.constraint(equalTo: view.topAnchor, constant: 130))
        constraints.append(pieChart.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 38))
        constraints.append(pieChart.widthAnchor.constraint(equalToConstant: 300))
        constraints.append(pieChart.heightAnchor.constraint(equalToConstant: 300))
        
        // Activate (Applying)
        NSLayoutConstraint.activate(constraints)
    }
}
