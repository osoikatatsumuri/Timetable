
import Foundation

class CalendarManager {
    let dateFormatter = DateFormatter()
    let calendar = Calendar.current
    let currentDate: Date = Date()
    
    let semesterBeginDate: Date
    
    init(firstSemesterBeginDate: String, secondSemesterBeginDate: String, dateSeparator: String) {
        dateFormatter.dateFormat = "dd/MM/yy"
        
        if (currentDate < dateFormatter.date(from: secondSemesterBeginDate)!) {
            semesterBeginDate = dateFormatter.date(from: firstSemesterBeginDate)!
        } else {
            semesterBeginDate = dateFormatter.date(from: secondSemesterBeginDate)!
        }
        
    }
    
    func getWeekNumber(date: Date) -> Int {
        let weekOfYear = calendar.component(.weekOfYear, from: date)
        return weekOfYear
    }
    
    func getWeekParity() -> Int {
        let currentWeekNumber = getWeekNumber(date: currentDate)
        let beginOfSemesterWeekNumber = getWeekNumber(date: semesterBeginDate)
        let actualWeekNumber = abs(currentWeekNumber - beginOfSemesterWeekNumber)
        
        return actualWeekNumber % 2 + 1
    }
}
