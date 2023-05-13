import Foundation
import SwiftSoup

class GroupHTMLParser {
    static func parseGroup(html: String) -> [GroupData] {
        var groups: [GroupData] = []
        
        do {
            let doc = try SwiftSoup.parse(html)
            let groupContent = try doc.select(Constants.groupContainerClassName)
            let groupLinks = try groupContent.select("a")
            
            for groupLink in groupLinks.array() {
                let name = try groupLink.text()
                let link = try groupLink.attr("href")

                groups.append(GroupData(name: name, url: link))
            }
        }  catch let error as NSError {
            print("Error: \(error.localizedDescription)")
        }
        
        return groups
    }
}
