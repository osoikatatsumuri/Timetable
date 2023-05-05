import Foundation

struct Course: Identifiable {
    let id: Int
    let title: String
    let url: String
    var groups: [Group]?
}
