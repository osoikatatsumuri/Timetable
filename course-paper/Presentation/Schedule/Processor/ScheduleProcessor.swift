import Foundation
import CoreData

class ScheduleProcessor {
    static func getUniqueDaysOfWeek(schedule: [Lesson]) -> [String] {
        return Array(Set(schedule.map {$0.unwrappedWeekDay})).sorted {
            Constants.weekdayPriority[$0]! < Constants.weekdayPriority[$1]!
        }
    }
    
    static func getScheduleForWeekday(schedule: [Lesson], day: String) -> [Lesson] {
        return schedule.filter {
            $0.unwrappedWeekDay == day
        }
    }
}
