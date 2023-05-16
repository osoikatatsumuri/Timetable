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
        let loader = ScheduleDataLoader(apiService: apiService)
        
        do {
            let html = try await apiService.getHTML()
            let fetchedLessons = await loader.loadData()
            
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
        let lessonCoreData = Lesson(context: context)
        
        lessonCoreData.id = UUID()
        lessonCoreData.auditorium = lesson.auditorium
        lessonCoreData.group = lesson.group
        lessonCoreData.subjectName = lesson.subject
        lessonCoreData.subjectType = lesson.subjectType
        lessonCoreData.teacherName = lesson.teacher
        lessonCoreData.timeStart = lesson.timeStart
        lessonCoreData.timeEnd = lesson.timeEnd
        lessonCoreData.weekDay = lesson.weekDay
        lessonCoreData.weekNumber = Int64(lesson.weekNumber ?? 0)
        
        group.addToLesson(lessonCoreData)
        
        DataManager.shared.save()
        fetchSchedule()
    }
}
