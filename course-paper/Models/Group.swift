import Foundation

struct Group: Identifiable {
    let id = UUID()
    let name: String
    let url: String
    let schedule: [Subject]?
}
