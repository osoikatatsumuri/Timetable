import SwiftUI

struct GroupsView: View {
    @ObservedObject var viewModel = GroupsViewModel()
    @Binding var course: Course
    
    var body: some View {
        VStack {
            List(viewModel.groups) { group in
                NavigationLink(destination: ScheduleView(group: group)) {
                    Text(group.name)
                }
            }   
            .overlay {
                if viewModel.loading {
                    ProgressView("Loading")
                }
            }
        }
        .onAppear(perform: {
            if (viewModel.groups.isEmpty) {
                viewModel.loadData(url: course.url)
            }
        })
    }
}
