import SwiftUI

struct GroupView: View {
    @ObservedObject var viewModel = GroupViewModel()
    @Binding var course: Course
    
    var body: some View {
        NavigationView {
            List {
                Text(course.title)
            }
        }
    }
}
