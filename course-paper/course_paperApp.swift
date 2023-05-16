import SwiftUI
import BackgroundTasks

@main
struct course_paperApp: App {
    @State var groups: [GroupData] = []
    
    var body: some Scene {
        WindowGroup {
            CoursesView()
        }
    }
}

