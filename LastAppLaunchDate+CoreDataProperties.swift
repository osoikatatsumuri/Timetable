//
//  LastAppLaunchDate+CoreDataProperties.swift
//  course-paper
//
//  Created by Yan Kurkin on 14.05.23.
//
//

import Foundation
import CoreData


extension LastAppLaunchDate {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LastAppLaunchDate> {
        return NSFetchRequest<LastAppLaunchDate>(entityName: "LastAppLaunchDate")
    }

    @NSManaged public var date: Date?
    @NSManaged public var id: UUID?

}

extension LastAppLaunchDate : Identifiable {

}
