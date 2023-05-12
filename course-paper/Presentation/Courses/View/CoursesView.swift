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
                        Text(course.title ?? "Unknown course")
                    }
                }
            }
            .background(Color(.systemGray6))
        }
    }
}

struct CoursesView_Previews: PreviewProvider {
    static var previews: some View {
        CoursesView()
    }
}

