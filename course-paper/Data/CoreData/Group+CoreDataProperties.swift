//
//  Group+CoreDataProperties.swift
//  course-paper
//
//  Created by Yan Kurkin on 12.05.23.
//
//

import Foundation
import CoreData


extension Group {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Group> {
        return NSFetchRequest<Group>(entityName: "Group")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var url: String?
    @NSManaged public var course: Course?
    @NSManaged public var lesson: NSSet?
    
    public var unwrappedName: String {
        name ?? "Неизвестная группа"
    }
    
    public var unwrappedURL: String {
        url ?? ""
    }
    
    public var lessonArray: [Lesson] {
        let set = lesson as? Set<Lesson> ?? []
        
        let weekdayPriority = ["Понедельник": 0,
                               "Вторник": 1,
                               "Среда": 2,
                               "Четверг": 3,
                               "Пятница": 4,
                               "Суббота": 5]
        
        return set.sorted {
            weekdayPriority[$0.unwrappedWeekDay]! < weekdayPriority[$1.unwrappedWeekDay]!
        }
    }
}

// MARK: Generated accessors for lesson
extension Group {

    @objc(addLessonObject:)
    @NSManaged public func addToLesson(_ value: Lesson)

    @objc(removeLessonObject:)
    @NSManaged public func removeFromLesson(_ value: Lesson)

    @objc(addLesson:)
    @NSManaged public func addToLesson(_ values: NSSet)

    @objc(removeLesson:)
    @NSManaged public func removeFromLesson(_ values: NSSet)

}

extension Group : Identifiable {

}
