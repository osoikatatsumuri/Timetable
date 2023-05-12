import Foundation
import CoreData
import SwiftSoup

class GroupsViewModel: ObservableObject {
    private let context = DataManager.shared.managedObjectContext
    @Published var isLoading: Bool?
    @Published var groups: [Group] = []
    
    var course: Course
    
    init(course: Course) {
        self.course = course
    }
    
    @MainActor
    func loadData() async throws {
        isLoading = true
        let apiService = APIService(url: course.unwrappedURL)
                
        do {
            let html = try await apiService.getHTML()

            let doc = try SwiftSoup.parse(html)
            let groupContent = try doc.select(Constants.groupContainerClassName)
            let groupLinks = try groupContent.select("a")
            
            for groupLink in groupLinks.array() {
                let name = try groupLink.text()
                let link = try groupLink.attr("href")
                
                addGroupToCoreData(name: name, url: link)
            }
            
        }  catch let error as NSError {
            print("Error: \(error.localizedDescription)")
        }
        
        isLoading = false
    }
    
    func fetchGroups() {
        groups = course.groupArray
    }
    
    func addGroupToCoreData(name: String, url: String) {
        let group = Group(context: context)
        group.id = UUID()
        group.name = name
        group.url = url
        
        course.addToGroup(group)
        save()
        fetchGroups()
    }
    
    func save() {
        do {
            try context.save()
        } catch {
            print("Error, while saving")
        }
    }
}
