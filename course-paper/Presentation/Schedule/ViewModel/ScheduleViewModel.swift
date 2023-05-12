import Foundation
import SwiftSoup

class ScheduleViewModel: ObservableObject {
    private let context = DataManager.shared.managedObjectContext
    @Published var isLoading: Bool?
    @Published var schedule: [Lesson] = []
    
    var group: Group
    
    init(group: Group) {
        self.group = group
    }
    
    func fetchSchedule() {
        schedule = group.lessonArray
    }
    
    @MainActor
    func getSchedule() async throws {
        isLoading = true
        
        let apiService = APIService(url: group.unwrappedURL)
        let parser = ScheduleHTMLParser(url: group.unwrappedURL)
        
        do {
            let html = try await apiService.getHTML()
            
            let doc = try SwiftSoup.parse(html)
            let rowsOfSchedule = try doc.select("tr")
            
            for subject in Array(rowsOfSchedule.array().dropFirst()) {
                let result = parser.parseSubject(subjectRow: subject)
                
                if let lesson = result {
                    addLessonToCoreData(lesson: lesson)
                    
                }
            }
        } catch Exception.Error(_, let message) {
            print(message)
        } catch {
            print(Constants.genericErrorMessage)
        }
        
        for lesson in schedule {
            debugPrint(lesson.unwrappedWeekDay)
        }
        
        isLoading = false
    }
    
    func addLessonToCoreData(lesson: LessonData) {
        let lessonDTO = Lesson(context: context)
        
        lessonDTO.id = UUID()
        lessonDTO.auditorium = lesson.auditorium
        lessonDTO.group = lesson.group
        lessonDTO.subjectName = lesson.subject
        lessonDTO.subjectType = lesson.subjectType
        lessonDTO.teacherName = lesson.teacher
        lessonDTO.time = lesson.time
        lessonDTO.weekDay = lesson.weekDay
        lessonDTO.weekNumber = Int64(lesson.weekNumber ?? 0)
        
        group.addToLesson(lessonDTO)
        
        save()
        fetchSchedule()
    }
    
    func save() {
        do {
            try context.save()
        } catch {
            print("Error while saving")
        }
    }
}
