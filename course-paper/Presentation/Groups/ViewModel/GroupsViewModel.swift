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
    func downloadAndPersistData() async throws {
        isLoading = true
        let apiService = APIService(url: course.unwrappedURL)
        let groupLoader = GroupLoader(apiService: apiService)
        
        let groups = await groupLoader.loadData()
        
        for group in groups {
            addGroupToCoreData(name: group.name, url: group.url)
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
