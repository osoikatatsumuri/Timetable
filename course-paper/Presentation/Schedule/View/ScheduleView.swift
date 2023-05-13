import SwiftUI

struct ScheduleView: View {
    @ObservedObject var viewModel: ScheduleViewModel
    
    init(group: Group) {
        self.viewModel = ScheduleViewModel(group: group)
        viewModel.fetchSchedule()
    }
    
    var body: some View {
        ZStack {
            Color(.systemGray6).ignoresSafeArea()

            VStack {
                GroupInfo(course: viewModel.courseName, group: viewModel.groupName, weekNumber: viewModel.weekNumber)
                
                if viewModel.getUniqueDaysOfWeek().isEmpty {
                    VStack {
                        Text("Нет расписания. Это что, халява?")
                    }
                } else {
                    List(viewModel.getUniqueDaysOfWeek(), id: \.self) { day in
                        NavigationLink(destination: SubjectList(schedule: viewModel.getScheduleForWeekday(day: day), course: viewModel.courseName, group: viewModel.groupName, weekNumber: viewModel.weekNumber)) {
                            Text(day)
                        }
                    }
                }
            }
            .overlay {
                if viewModel.isLoading ?? false {
                    ZStack {
                        Color(.systemGray6).ignoresSafeArea()
                        ProgressView("Loading")
                    }
                }
            }
            .task {
                if viewModel.schedule.isEmpty {
                    try? await viewModel.downloadAndPersistData()
                }
            }
        }
    }
}
