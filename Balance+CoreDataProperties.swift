//
//  Balance+CoreDataProperties.swift
//  MoneyTrackingApplication
//
//  Created by Вадим Бенько on 14.03.2021.
//
//

import Foundation
import CoreData


extension Balance {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Balance> {
        return NSFetchRequest<Balance>(entityName: "Balance")
    }

    @NSManaged public var income: Int64
    @NSManaged public var mainBalance: Int64
    @NSManaged public var outcome: Int64

}

extension Balance : Identifiable {

}
