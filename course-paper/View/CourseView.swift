import SwiftSoup
import SwiftUI

struct CourseView: View {
    @State var courses = [
        Course(id: 1, title: "1 курс", url: "https://mmf.bsu.by/ru/raspisanie-zanyatij/dnevnoe-otdelenie/1-kurs/"),
        Course(id: 2, title: "2 курс", url: "https://mmf.bsu.by/ru/raspisanie-zanyatij/dnevnoe-otdelenie/2-kurs/"),
        Course(id: 3, title: "3 курс", url: "https://mmf.bsu.by/ru/raspisanie-zanyatij/dnevnoe-otdelenie/3-kurs/"),
        Course(id: 4, title: "4 курс", url: "https://mmf.bsu.by/ru/raspisanie-zanyatij/dnevnoe-otdelenie/4-kurs/")
    ]
    
    var body: some View {
        NavigationView {
            List($courses) { $course in
                NavigationLink(destination: GroupView(course: $course)) {
                    Text(course.title)
                }
            }
        }
        .navigationTitle("Выбор курса")
    }
}


struct CourseView_Previews: PreviewProvider {
    static var previews: some View {
        CourseView()
    }
}
