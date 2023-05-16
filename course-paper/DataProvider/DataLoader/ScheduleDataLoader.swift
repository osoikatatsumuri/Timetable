import Foundation
import SwiftSoup

class ScheduleDataLoader {
    let apiService: APIService
    
    init(apiService: APIService) {
        self.apiService = apiService
    }
    
    func loadData() async -> [LessonData] {
        var schedule: [LessonData] = []
        let parser = ScheduleHTMLParser()
        
        do {
            let html = try await apiService.getHTML()
            let doc = try SwiftSoup.parse(html)
            let rowsOfSchedule = try doc.select("tr")
            
            for subject in Array(rowsOfSchedule.array().dropFirst()) {
                let result = parser.parseSubject(subjectRow: subject)
                
                if let lesson = result {
                    schedule.append(lesson)
                }
            }
        } catch Exception.Error(_, let message) {
            print(message)
        } catch {
            print(Constants.genericErrorMessage)
        }
        
        return schedule
    }
}
