import Foundation
import CoreData

class DataManager: ObservableObject {
    
    let container: NSPersistentContainer
    static let shared = DataManager()
    
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Timetable")
        
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        
        container.loadPersistentStores() { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
        
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    var managedObjectContext: NSManagedObjectContext {
        return container.viewContext
    }
}
