import SwiftUI

struct GroupView: View {
    @Binding var course: Course
    
    var body: some View {
        NavigationView {
            List {
                Text(course.title)
            }
        }
    }
}
