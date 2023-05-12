import Foundation

struct LessonData: Identifiable {
    var id = UUID()
    var weekDay = ""
    var time = ""
    var group = ""
    var weekNumber: Int?
    var subject = ""
    var teacher = ""
    var subjectType = ""
    var auditorium = ""
    
    func isEmpty() -> Bool {
        return weekDay == "" && subject == ""
    }
}