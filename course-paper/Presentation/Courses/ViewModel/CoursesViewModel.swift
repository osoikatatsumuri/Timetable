    import Foundation
    import SwiftUI
    import CoreData
        
    class CoursesViewModel: ObservableObject {
        private let context: NSManagedObjectContext = DataManager.shared.managedObjectContext
        @Published var courses: [Course] = []
        
        init() {
            fetchCourseData()
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
