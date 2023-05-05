import Foundation

struct Group: Identifiable {
    let id = UUID()
    var name: String
    let url: String
    var schedule: [Subject]?
}
