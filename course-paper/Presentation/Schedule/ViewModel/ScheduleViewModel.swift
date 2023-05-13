import Foundation
import SwiftSoup

class ScheduleViewModel: ObservableObject {
    private let context = DataManager.shared.managedObjectContext
    var group: Group
    
    @Published var isLoading: Bool?
    @Published var schedule: [Lesson] = []
    @Published var weekNumber: Int
    
    var courseName: String
    var groupName: String
    
    
    init(group: Group) {
        let calendarManager = CalendarManager(firstSemesterBeginDate: "01/09/2022", secondSemesterBeginDate: "06/02/2023", dateSeparator: "/")
        weekNumber = calendarManager.getWeekParity()
        
        self.group = group
        courseName = group.course!.unwrappedTitle
        groupName = group.unwrappedName
    }
    
    func getUniqueDaysOfWeek() -> [String] {
        return ScheduleProcessor.getUniqueDaysOfWeek(schedule: schedule)
    }
    
    func getScheduleForWeekday(day: String) -> [Lesson] {
        return ScheduleProcessor.getScheduleForWeekday(schedule: schedule, day: day)
    }
    
    func fetchSchedule() {
        schedule = group.lessonArray
    }
        
    @MainActor
    func downloadAndPersistData() async throws {
        isLoading = true
        
        let apiService = APIService(url: group.unwrappedURL)
        let loader = ScheduleLoader(apiService: apiService)
        
        do {
            let html = try await apiService.getHTML()
            let fetchedLessons = await loader.loadData(html: html)
            
            for lesson in fetchedLessons {
                addLessonToCoreData(lesson: lesson)
            }
            
        } catch Exception.Error(_, let message) {
            print(message)
        } catch {
            print(Constants.genericErrorMessage)
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
        lessonDTO.timeStart = lesson.timeStart
        lessonDTO.timeEnd = lesson.timeEnd
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
