import SwiftUI

struct ScheduleView: View {
    @State var group: Group
    @ObservedObject var viewModel = ScheduleViewModel()
    
    var body: some View {
        VStack {
            Text("Неделя " + String(viewModel.numberOfWeek))

            ScrollView {
                LazyVStack(spacing: 10) {
                    ForEach(viewModel.schedule) { subject in
                        SubjectView(subject: subject)
                        Divider()
                    }
                }
                .padding()
            }
            .overlay {
                if viewModel.loading {
                    ProgressView("Loading...")
                }
            }
            .onAppear(perform: {
                if viewModel.schedule.isEmpty {
                    viewModel.loadData(url: group.url)
                }
            })
        }.background(Color(.systemGray6))
    }
}
