import Foundation

struct Constants {
    static let separator = "_"
    static let timeSeparator = "–"
    static let genericErrorMessage = "Что-то пошло не так. Пожалуйста, обратитесь к разработчику"
    
    static let groupContainerClassName = "section.content-area.default-format"
    static let subjectTeacherClassName = "td.subject-teachers"
    static let weekdayClassName = "td.weekday"
    static let timeClassName = "td.time"
    static let groupClassName = "td.remarks"
    static let typeClassName = "td.lecture-practice"
    static let auditoriumClassName = "td.room"
    
    static let weekdayPriority = ["Понедельник": 0,
                           "Вторник": 1,
                           "Среда": 2,
                           "Четверг": 3,
                           "Пятница": 4,
                           "Суббота": 5]
}
