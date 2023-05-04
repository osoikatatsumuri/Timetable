import SwiftUI

struct GroupView: View {
    @ObservedObject var viewModel = GroupViewModel()
    @Binding var course: Course
    
    var body: some View {
        NavigationView {
            List(viewModel.groups) { group in
                Text(group.name)
            }
            .onAppear(perform: {
                if (viewModel.groups.isEmpty) {
                    viewModel.loadData(url: course.url)
                }
            })
        }
    }
}
