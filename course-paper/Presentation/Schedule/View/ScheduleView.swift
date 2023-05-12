import SwiftUI

struct ScheduleView: View {
    @ObservedObject var viewModel: ScheduleViewModel
    
    init(group: Group) {
        self.viewModel = ScheduleViewModel(group: group)
        viewModel.fetchSchedule()
    }
    
    var body: some View {
        VStack {
            List(viewModel.schedule) { lesson in
                SubjectView(lesson: lesson)
            }
        }
        .overlay {
            if viewModel.isLoading ?? false {
                ProgressView("Loading...")
            }
        }
        .task {
            if viewModel.schedule.isEmpty {
                try? await viewModel.getSchedule()
            }
        }
    }
}
