import Foundation
import SwiftSoup

class GroupDataLoader {
    let apiService: APIService
    
    init(apiService: APIService) {
        self.apiService = apiService
    }
    
    func loadData() async -> [GroupData] {
        var groups: [GroupData] = []
        
        do {
            let html = try await apiService.getHTML()
            let parsedGroups = GroupHTMLParser.parseGroup(html: html)
            groups = parsedGroups
        }  catch let error as NSError {
            print("Error: \(error.localizedDescription)")
        }
        
        return groups
    }
}
