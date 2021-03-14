//
//  CoreDataManager.swift
//  MoneyTrackingApplication
//
//  Created by Вадим Бенько on 13.03.2021.
//

import Foundation
import CoreData

class CoreDataManager {
    // MARK: - Static properties
    static let entityNameFirst: String = "MTCardModel"
    
    static let shared = CoreDataManager()
    
    // MARK: - Init
    private init() { }
    
    // MARK: - Core Data
    private lazy var persistantContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: CoreDataManager.entityNameFirst)
        container.loadPersistentStores { (description, error) in
            Swift.debugPrint("Store: \(description)")
            
            if let error = error {
                fatalError("Unable to load persistent stores: \(error)")
            }
        }
        
        return container
    }()
    
    private var context: NSManagedObjectContext {
        self.persistantContainer.viewContext
    }
    
    // MARK: - Methods
    func writeDataInBalance(mainBalance: Int64, income: Int64, outcome: Int64) {
        guard let entity = NSEntityDescription.entity(forEntityName: "Balance",
                                                      in: self.context) else { return }
        let balance = NSManagedObject(entity: entity, insertInto: self.context)
        balance.setValue(mainBalance, forKeyPath: "mainBalance")
        balance.setValue(income, forKeyPath: "income")
        balance.setValue(outcome, forKeyPath: "outcome")
        
        do {
            try self.context.save()
        } catch let error as NSError {
            Swift.debugPrint("Couldn't save data. \(error), \(error.userInfo)")
        }
    }
    
    func readBalance() -> [Int64] {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Balance")
        do {
            guard let result = try self.context.fetch(fetchRequest) as? [Balance] else { return [] }
            let array = [result[0].mainBalance, result[0].income, result[0].outcome]
            return array
        } catch let error as NSError {
            Swift.debugPrint("Couldn't read data. \(error), \(error.userInfo)")
        }
        return []
    }
    
    func writeDataInGoals(goal: String, sum: Int64, currentSum: Int64) {
        let goals = Goals(context: self.context)
        goals.goal = goal
        goals.sum = sum
        goals.count += 1
        goals.currentSum = currentSum
        
        do {
            try self.context.save()
        } catch let error as NSError {
            Swift.debugPrint("Couldn't save data. \(error), \(error.userInfo)")
        }
    }
    
    func readGoals() -> [(String, Int64, Int64)] {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Goals")
        do {
            guard let result = try self.context.fetch(fetchRequest) as? [Goals] else { return [] }
            var array: [(String, Int64, Int64)] = []
            result.forEach {
                array.append(($0.goal, $0.sum, $0.currentSum))
            }
            return array
        } catch let error as NSError {
            Swift.debugPrint("Couldn't read data. \(error), \(error.userInfo)")
        }
        return []
    }
    
    func readGoalsCount() -> Int {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Goals")
        do {
            guard let result = try self.context.fetch(fetchRequest) as? [Goals] else { return 0 }
            return result.count
        } catch let error as NSError {
            Swift.debugPrint("Couldn't read data. \(error), \(error.userInfo)")
        }
        return 0
    }
    
    func writeDataInCategory(parametrs: String, sum: Int64, flag: Bool) {
        let category = Category(context: self.context)
        category.parametrs = parametrs
        category.sum = sum
        category.flag = flag

        do {
            try self.context.save()
        } catch let error as NSError {
            Swift.debugPrint("Couldn't save data. \(error), \(error.userInfo)")
        }
    }
    
    
    func readCategory() -> [(String, Int64, Bool)] {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Category")
        do {
            guard let result = try self.context.fetch(fetchRequest) as? [Category] else { return [] }
            var array: [(String, Int64, Bool)] = []
            result.forEach {
                array.append(($0.parametrs, $0.sum, $0.flag))
            }
            return array
        } catch let error as NSError {
            Swift.debugPrint("Couldn't read data. \(error), \(error.userInfo)")
        }
        return []
    }
    
    func remove(from name: String) {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: name)
        fetchRequest.returnsObjectsAsFaults = false
        
        do {
            let result = try self.context.fetch(fetchRequest)
            result.forEach { self.context.delete($0) }
            
            try self.context.save()
        } catch let error as NSError {
            Swift.debugPrint("Couldn't remove data. \(error), \(error.userInfo)")
        }
    }
    
}
