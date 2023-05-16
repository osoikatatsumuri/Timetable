//
//  Course+CoreDataProperties.swift
//  course-paper
//
//  Created by Yan Kurkin on 12.05.23.
//
//

import Foundation
import CoreData


extension Course {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Course> {
        return NSFetchRequest<Course>(entityName: "Course")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var title: String?
    @NSManaged public var url: String?
    @NSManaged public var group: NSSet?

    public var unwrappedTitle: String {
        title ?? ""
    }
    
    public var unwrappedURL: String {
        url ?? ""
    }
    
    public var groupArray: [Group] {
        let set = group as? Set<Group> ?? []
        
        return set.sorted() {
            $0.unwrappedName < $1.unwrappedName
        }
    }
}

// MARK: Generated accessors for group
extension Course {

    @objc(addGroupObject:)
    @NSManaged public func addToGroup(_ value: Group)

    @objc(removeGroupObject:)
    @NSManaged public func removeFromGroup(_ value: Group)

    @objc(addGroup:)
    @NSManaged public func addToGroup(_ values: NSSet)

    @objc(removeGroup:)
    @NSManaged public func removeFromGroup(_ values: NSSet)

}

extension Course : Identifiable {

}
