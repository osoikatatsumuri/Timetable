import SwiftUI

struct GroupsView: View {
    @ObservedObject var viewModel: GroupsViewModel
    
    init(course: Course) {
        self.viewModel = GroupsViewModel(course: course)
        viewModel.fetchGroups()
    }
    
    var body: some View {
        VStack {
            List(viewModel.groups) { group in
                NavigationLink(destination: ScheduleView(group: group)) {
                    Text(group.unwrappedName)
                }
            }
            .overlay {
                if viewModel.isLoading ?? false {
                    ProgressView()
                }
            }
            .task {
                if viewModel.groups.isEmpty {
                    try? await viewModel.loadData()
                }
            }
        }
    }
    
}
