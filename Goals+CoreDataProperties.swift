//
//  Goals+CoreDataProperties.swift
//  MoneyTrackingApplication
//
//  Created by Вадим Бенько on 14.03.2021.
//
//

import Foundation
import CoreData


extension Goals {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Goals> {
        return NSFetchRequest<Goals>(entityName: "Goals")
    }

    @NSManaged public var goal: String
    @NSManaged public var sum: Int64
    @NSManaged public var count: Int64
    @NSManaged public var currentSum: Int64

}

extension Goals : Identifiable {

}
