//
//  Category+CoreDataProperties.swift
//  MoneyTrackingApplication
//
//  Created by Вадим Бенько on 14.03.2021.
//
//

import Foundation
import CoreData


extension Category {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Category> {
        return NSFetchRequest<Category>(entityName: "Category")
    }

    @NSManaged public var parametrs: String
    @NSManaged public var sum: Int64
    @NSManaged public var flag: Bool

}

extension Category : Identifiable {

}
