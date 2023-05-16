import Foundation
import CoreData

class DataManager: ObservableObject {
    
    var container: NSPersistentContainer
    static let shared = DataManager()
    
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Timetable")
        
        setupContainer()
    }
    
    private func setupContainer(inMemory: Bool = false) {
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
    
    func deleteAllInstances(for entity: String) {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: entity)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try DataManager.shared.container.persistentStoreCoordinator.execute(deleteRequest, with: DataManager.shared.managedObjectContext)
            
        } catch let error as NSError {
            print(error)
        }
    }
    
    func updateData() {
        
    }
    
    func save() {
        do {
            try managedObjectContext.save()
        } catch {
            print("Error saving")
        }
    }
    
    var managedObjectContext: NSManagedObjectContext {
        return container.viewContext
    }
}
