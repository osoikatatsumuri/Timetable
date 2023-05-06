import Foundation

enum ScheduleParserError: Error {
    case fetchError(String)
    case parseError(String)
}
