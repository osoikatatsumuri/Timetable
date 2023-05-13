import SwiftUI

struct GroupsView: View {
    @ObservedObject var viewModel: GroupsViewModel
    let course: Course
    
    init(course: Course) {
        self.viewModel = GroupsViewModel(course: course)
        self.course = course
        viewModel.fetchGroups()
    }
    
    var body: some View {
        ZStack {
            Color(.systemGray6).ignoresSafeArea()
            
            VStack {
                Text(course.unwrappedTitle)
                    .font(.headline)
                
                List(viewModel.groups) { group in
                    NavigationLink(destination: ScheduleView(group: group)) {
                        Text(group.unwrappedName)
                    }
                }
            }
            .overlay {
                if viewModel.isLoading ?? false {
                    ZStack {
                        Color(.systemGray6).ignoresSafeArea()
                        ProgressView("Loading")
                    }
                }
            }
            .task {
                if viewModel.groups.isEmpty {
                    try? await viewModel.downloadAndPersistData()
                }
            }
        }
    }
    
}
