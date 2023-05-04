import SwiftSoup
import SwiftUI

struct CoursesView: View {
    @State var courses = [
        Course(id: 1, title: "1 курс", url: "https://mmf.bsu.by/ru/raspisanie-zanyatij/dnevnoe-otdelenie/1-kurs/", groups: nil),
        Course(id: 2, title: "2 курс", url: "https://mmf.bsu.by/ru/raspisanie-zanyatij/dnevnoe-otdelenie/2-kurs/", groups: nil),
        Course(id: 3, title: "3 курс", url: "https://mmf.bsu.by/ru/raspisanie-zanyatij/dnevnoe-otdelenie/3-kurs/", groups: nil),
        Course(id: 4, title: "4 курс", url: "https://mmf.bsu.by/ru/raspisanie-zanyatij/dnevnoe-otdelenie/4-kurs/", groups: nil)
    ]
    
    var body: some View {
        NavigationView {
            List($courses) { $course in
                NavigationLink(destination: GroupsView(course: $course)) {
                    Text(course.title)
                }
            }
        }
        .navigationTitle("Выбор курса")
    }
}


struct CoursesView_Previews: PreviewProvider {
    static var previews: some View {
        CoursesView()
    }
}
