import SwiftSoup
import SwiftUI

struct CoursesView: View {
    @ObservedObject var viewModel: CoursesViewModel
    
    init() {
        self.viewModel = CoursesViewModel()
        viewModel.fetchCourseData()
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

