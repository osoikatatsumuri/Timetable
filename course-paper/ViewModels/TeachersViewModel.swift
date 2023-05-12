import Foundation
import SwiftUI


class TeachersViewModel: ObservableObject {
    @Published var textInput: String = ""
    @Published var isLoaded: Bool = false
    
    func fetchSchedules(for coursesViewModel: CoursesViewModel) {
        let scheduleViewModel = ScheduleViewModel()
        let group = DispatchGroup()
        
        for index in coursesViewModel.courses.indices {
            for innerIndex in (coursesViewModel.courses[index].groups ?? []).indices {
                group.enter()
                guard let groupURL = coursesViewModel.courses[index].groups?[innerIndex].url else {
                    group.leave()
                    continue
                }
                
                scheduleViewModel.loadData(url: groupURL) { result in
                    DispatchQueue.main.async {
                        coursesViewModel.courses[index].groups![innerIndex].schedule = result
                        group.leave()
                    }
                }
            }
        }
        
        group.notify(queue: .main) {
            self.isLoaded = true
            debugPrint(self.isLoaded)
        }
    }
    
    
}
