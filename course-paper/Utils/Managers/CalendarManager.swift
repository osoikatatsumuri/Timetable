
import Foundation

class CalendarManager {
    
    static func getNumberOfWeek() -> Int {
        let calendar = Calendar(identifier: .gregorian)
        let weekOfYear = calendar.component(.weekOfYear, from: Date(timeIntervalSinceNow: 0))
        return weekOfYear
    }
    
    static func getParityOfWeek(week: Int) -> Int {
        return week % 2 + 1
    }
}
