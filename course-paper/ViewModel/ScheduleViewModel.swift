import Foundation

class ScheduleViewModel: ObservableObject {
    @Published var loading = true
    @Published var schedule: ContiguousArray<Subject> = []
    @Published var numberOfWeek = CalendarManager.getParityOfWeek(week: CalendarManager.getNumberOfWeek())
    
    func loadData(url: String) {
        let scheduleParser = ScheduleParser(url: url)
        
        scheduleParser.getSchedule() { result in
            switch result {
                case .success(let subjects):
                    DispatchQueue.main.async {
                        self.schedule = subjects
                        self.loading = false
                    }   
                case .failure(let error):
                    print("Some error occured: \(error)")
            }
        }
    }
}
