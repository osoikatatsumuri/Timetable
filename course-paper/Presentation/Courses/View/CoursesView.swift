import SwiftSoup
import SwiftUI
import CoreData //

struct CoursesView: View {
    @ObservedObject var viewModel: CoursesViewModel
    
    init() {
        self.viewModel = CoursesViewModel()
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                List(viewModel.courses) { course in
                    NavigationLink(destination: GroupsView(course: course)) {
                        Text(course.unwrappedTitle)
                    }
                }
            }
            .onAppear() {
                if viewModel.courses.isEmpty {
                    viewModel.uploadCourses()
                } else {
                    viewModel.updateAppLaunchDate()
                }
            }
        }
        .background(Color(.systemGray6))
    }
}

struct CoursesView_Previews: PreviewProvider {
    static var previews: some View {
        CoursesView()
    }
}

