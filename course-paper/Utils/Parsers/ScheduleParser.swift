import Foundation
import SwiftSoup

class ScheduleParser {
    var apiService: APIService
    
    init(url: String) {
        apiService = APIService(url: url)
    }
    
    func getSchedule(completion: @escaping(Result<ContiguousArray<Subject>, ScheduleParserError>) -> Void) {
        apiService.getHTML() { html in
            guard let html = html else {
                completion(.failure(.fetchError("Ошибка при загрузке HTML-страницы")))
                return
            }
            
            do {
                let doc = try SwiftSoup.parse(html)
                let rowsOfSchedule = try doc.select("tr")
                var subjects: ContiguousArray<Subject> = []
                
                for subject in Array(rowsOfSchedule.array().dropFirst()) {
                    let result = self.parseSubject(subjectRow: subject)
                    
                    switch result {
                        case .success(let subject):
                            if (!subject.isEmpty()) {
                                subjects.append(subject)
                            }
                        case .failure(let error):
                            completion(.failure(error))
                    }
                }
                
                completion(.success(subjects))
                
            } catch Exception.Error(_, let message) {
                completion(.failure(.parseError(message)))
            } catch {
                completion(.failure(.parseError(Constants.genericErrorMessage)))
            }
        }
    }
    
    private func typeOfClassProcessor(type: String) -> String {
        if type == "л" {
            return "Лекция"
        } else if type == "п" {
            return "Практика"
        }
        
        return type
    }
    
    private func parseSubject(subjectRow: Element) -> Result<Subject, ScheduleParserError>{
        do {
            let timeRegex = /\d{1,2}.\d{2}-\d{1,2}.\d{2}/
            
            let subjectTeachers = try subjectRow.select("td.subject-teachers")
            let weekDay = try subjectRow.select("td.weekday").text()
            var time = try subjectRow.select("td.time").text()
            let group = try subjectRow.select("td.remarks").text()
            let subjectTeachersText = HTMLParser.getTextWithLineBreaks(element: subjectTeachers.first()!)
            var typeOfClass = try subjectRow.select("td.lecture-practice").text()
            let auditorium = try subjectRow.select("td.room").text()
            
            typeOfClass = self.typeOfClassProcessor(type: typeOfClass)
            
            let currentGroup = self.getGroup(group)
            let weekNumber = self.getWeekNumber(group)
            
            var teacher = ""
            
            if subjectTeachersText.contains(timeRegex) {
                if let match = subjectTeachersText.firstMatch(of: timeRegex) {
                    time = String(match.0)
                }
            } else {
                teacher = self.getTeacherName(subjectTeachersText)
            }
            
            let subjectName = getSubjectName(subjectTeachersText)
            
            let subject = Subject(
                weekDay: weekDay,
                time: time,
                group: currentGroup,
                weekNumber: weekNumber,
                subject: subjectName,
                teacher: teacher,
                subjectType: typeOfClass,
                auditorium: auditorium
            )
    
            return .success(subject)
            
        } catch Exception.Error(_, let message) {
            return .failure(.parseError(message))
        } catch {
            return .failure(.parseError(Constants.genericErrorMessage))
        }
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
