import Foundation
import SwiftSoup

class ScheduleHTMLParser {
    
    private func typeOfClassProcessor(type: String) -> String {
        if type == "л" {
            return "Лекция"
        } else if type == "п" {
            return "Практика"
        }
        
        return type
    }
    
    public func parseLessonTime(time: String) -> [Date] {
        let pattern = "–|-"
        let timeComponents = time.components(separatedBy: CharacterSet(charactersIn: pattern))
        var times: [Date] = []
        
        for item in timeComponents {
            times.append(self.timeParser(time: String(item)))
        }
    
        return times
    }
    
    public func timeParser(time: String) -> Date {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "HH:mm"
         let dateFromStr = dateFormatter.date(from: time)!
        
        return dateFromStr
    }
    
    public func parseSubject(subjectRow: Element) -> LessonData? {
        do {
            let timeRegex = /[^\(]\d{1,2}.\d{2}-\d{1,2}.\d{2}[^\)]/
            
            let subjectTeachers = try subjectRow.select(Constants.subjectTeacherClassName)
            let weekDay = try subjectRow.select(Constants.weekdayClassName).text()
            var time = try subjectRow.select(Constants.timeClassName).text()
            
            let beginAndEndTime = parseLessonTime(time: time)
            var beginTime = beginAndEndTime[0]
            var endTime = beginAndEndTime[1]
            
            let group = try subjectRow.select(Constants.groupClassName).text()
            var typeOfClass = try subjectRow.select(Constants.typeClassName).text()
            let auditorium = try subjectRow.select(Constants.auditoriumClassName).text()
            
            var subjectTeachersText = HTMLParser.getTextWithLineBreaks(element: subjectTeachers.first()!)
            
            typeOfClass = self.typeOfClassProcessor(type: typeOfClass)
            
            let currentGroup = self.getGroup(group)
            let weekNumber = self.getWeekNumber(group)
            
            var teacher = ""
            
            if subjectTeachersText.contains(timeRegex) {
                if let match = subjectTeachersText.firstMatch(of: timeRegex) {
                    time = String(match.0)
                    let newBeginAndEndTime = parseLessonTime(time: time)
                    beginTime = newBeginAndEndTime[0]
                    endTime = newBeginAndEndTime[1]
                    
                    subjectTeachersText.replace(timeRegex, with: "")
                }
            } else {
                teacher = self.getTeacherName(subjectTeachersText)
            }
            
            let subjectName = getSubjectName(subjectTeachersText)
            
            return LessonData(
                            weekDay: weekDay,
                            timeStart: beginTime,
                            timeEnd: endTime,
                            group: currentGroup,
                            weekNumber: weekNumber,
                            subject: subjectName,
                            teacher: teacher,
                            subjectType: typeOfClass,
                            auditorium: auditorium
                        )
        } catch {
            print(Constants.genericErrorMessage)
        }
        
        return nil
    }
    
    
    func getWeekNumber(_ groupText: String) -> Int? {
        do {
            let numberOfWeek = try Regex("[1-2]н")
            
            if let match = groupText.firstMatch(of: numberOfWeek) {
                let filteredNumberOfWeek = String(match.0).filter { char in
                    return char.isNumber
                }
                
                if let result = Int(filteredNumberOfWeek) {
                    return result
                }
            }
            
        } catch Exception.Error(_, let message) {
            print(message)
        } catch {
            print("error")
        }
        
        return nil
    }
    
    func getGroup(_ groupText: String) -> String {
        do {
            let group = try Regex("[а-м]|[о-я]")
            
            if let match = groupText.firstMatch(of: group) {
                return String(match.0)
            }
            
        } catch Exception.Error(_, let message) {
            print(message)
        } catch {
            print("error")
        }
        
        return ""
    }
    
    func getSubjectName(_ subjectTeachersText: String) -> String {
        let subjectTeachersArray = subjectTeachersText.split(separator: Constants.separator)
        
        if (subjectTeachersArray.count == 0) {
            return ""
        }
        
        return String(subjectTeachersArray[0])
    }
    
    private func parseSubjectTeacherText(subjectTeacher: String) {
        let timeRegex = /\d{1,2}.\d{2}-\d{1,2}.\d{2}/
        
        if (subjectTeacher.contains(timeRegex)) {
            
        }
    }
    
    func getTeacherName(_ subjectTeachersText: String) -> String {
        let subjectTeachersArray = subjectTeachersText.split(separator: Constants.separator)
        let time = /\d{1,2}.\d{2}-\d{1,2}.\d{2}/
        
        if (subjectTeachersArray.count != 2) {
            return ""
        }
        
        let teacher = String(subjectTeachersArray[1])
        
        if (teacher.contains(time)) {
            debugPrint("dfdsf" +  teacher)
        }
        
        return String(subjectTeachersArray[1])
    }
}
