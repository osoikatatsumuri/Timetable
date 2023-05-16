//
//  Lesson+CoreDataProperties.swift
//  course-paper
//
//  Created by Yan Kurkin on 12.05.23.
//
//

import Foundation
import CoreData


extension Lesson {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Lesson> {
        return NSFetchRequest<Lesson>(entityName: "Lesson")
    }

    @NSManaged public var auditorium: String?
    @NSManaged public var group: String?
    @NSManaged public var id: UUID?
    @NSManaged public var subjectName: String?
    @NSManaged public var subjectType: String?
    @NSManaged public var teacherName: String?
    @NSManaged public var time: String?
    @NSManaged public var weekDay: String?
    @NSManaged public var weekNumber: Int64
    @NSManaged public var lessonOrigin: Group?

    public var unwrappedAuditorium: String {
        auditorium ?? ""
    }
    
    public var unwrappedGroup: String {
        group ?? ""
    }
    
    public var unwrappedSubjectName: String {
        subjectName ?? ""
    }
    
    public var unwrappedSubjectType: String {
        subjectType ?? ""
    }
    
    public var unwrappedTeacherName: String {
        teacherName ?? ""
    }
    
    public var unwrappedTime: String {
        time ?? ""
    }
    
    public var unwrappedWeekDay: String {
        weekDay ?? ""
    }
    
    public var unwrappedWeekNumber: Int {
        Int(weekNumber)
    }
}

extension Lesson : Identifiable {

}
