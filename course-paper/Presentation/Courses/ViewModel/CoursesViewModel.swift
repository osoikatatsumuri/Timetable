import Foundation
import SwiftUI
import CoreData

class CoursesViewModel: ObservableObject {
    private let context: NSManagedObjectContext = DataManager.shared.managedObjectContext
    @Published var lastAppLaunchDate: LastAppLaunchDate = LastAppLaunchDate(context: DataManager.shared.managedObjectContext)
    @Published var courses: [Course] = []
    
    init() {
        fetchLastAppLaunchDate()
        fetchCourseData()
    }
    
    func removeCourses() {
        DataManager.shared.deleteAllInstances(for: "Course")
        
        self.courses = []
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
    
    func reuploadCourses() {
        self.removeCourses()
        self.uploadCourses()
    }
    
    func fetchCourseData() {
        let request = NSFetchRequest<Course>(entityName: "Course")
        
        do {
            courses = try context.fetch(request)
        } catch {
            print("Debug: Some Error occurred while fetching")
        }
    }
    
    func fetchLastAppLaunchDate() {
        let request = NSFetchRequest<LastAppLaunchDate>(entityName: "LastAppLaunchDate")
        
        do {
            let results = try context.fetch(request)
            
            if let lastLaunch = results.first, lastLaunch.date != nil{
                lastAppLaunchDate = lastLaunch
            } else {
                lastAppLaunchDate = LastAppLaunchDate(context: context)
                lastAppLaunchDate.date = Date()
                DataManager.shared.save()
            }
        } catch {
            print("Debug: Some Error occurred while fetching")
        }
    }
    
    func updateAppLaunchDate() {
        let now = Date()
        
        if let lastLaunchDate = lastAppLaunchDate.date {
                        
            let twelveHours: TimeInterval = 12 * 60 * 60
                                                
            if now.timeIntervalSince(lastLaunchDate) > twelveHours {
                lastAppLaunchDate.date = now
                DataManager.shared.save()

                self.reuploadCourses()
            }
        }
    }
    
    func addCourseToCoreData(title: String, url: String) {
        let course = Course(context: context)
        course.id = UUID()
        course.title = title
        course.url = url
        
        DataManager.shared.save()
        
        fetchCourseData()
    }
    
    func addLastAppLaunchDateToCoreData(date: Date)  {
        let lastAppLaunchDate = LastAppLaunchDate(context: context)
        lastAppLaunchDate.date = date
        
        DataManager.shared.save()
        fetchLastAppLaunchDate()
    }
}
