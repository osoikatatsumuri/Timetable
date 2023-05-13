    import Foundation
    import SwiftUI
    import CoreData
        
    class CoursesViewModel: ObservableObject {
        private let context: NSManagedObjectContext = DataManager.shared.managedObjectContext
        @Published var courses: [Course] = []
        
        init() {
            fetchCourseData()
        }
        
        func uploadCourses() {
            self.addCourseToCoreData(title: "1 курс", url:
                                        "https://mmf.bsu.by/ru/raspisanie-zanyatij/dnevnoe-otdelenie/1-kurs/")
            self.addCourseToCoreData(title: "2 курс", url:
                                        "https://mmf.bsu.by/ru/raspisanie-zanyatij/dnevnoe-otdelenie/2-kurs/")
            self.addCourseToCoreData(title: "3 курс", url:
                                        "https://mmf.bsu.by/ru/raspisanie-zanyatij/dnevnoe-otdelenie/3-kurs/")
            self.addCourseToCoreData(title: "4 курс", url:
                                        "https://mmf.bsu.by/ru/raspisanie-zanyatij/dnevnoe-otdelenie/4-kurs/")
        }
        
        func fetchCourseData() {
            let request = NSFetchRequest<Course>(entityName: "Course")
            
            do {
                courses = try context.fetch(request)
            } catch {
                print("Debug: Some Error occurred while fetching")
            }
        }
        
        func addCourseToCoreData(title: String, url: String) {
            let course = Course(context: context)
            course.id = UUID()
            course.title = title
            course.url = url
            
            save()
            fetchCourseData()
        }
        
        func save() {
            do {
                try context.save()
            } catch {
                print("Error saving")
            }
        }
    }
