//
//  ApplicationDate+CoreDataProperties.swift
//  course-paper
//
//  Created by Yan Kurkin on 14.05.23.
//
//

import Foundation
import CoreData


extension ApplicationDate {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ApplicationDate> {
        return NSFetchRequest<ApplicationDate>(entityName: "ApplicationDate")
    }

    @NSManaged public var startDate: Date?

}

extension ApplicationDate : Identifiable {

}
