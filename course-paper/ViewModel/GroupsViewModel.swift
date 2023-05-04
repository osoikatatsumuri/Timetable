import Foundation
import SwiftSoup

class GroupViewModel: ObservableObject {
    @Published var groups: [Group] = []
    
    func loadData(url: String) {
        let apiService = APIService(url: url)
        
        apiService.getHTML() { html in
            guard let html = html else {
                return
            }
            do {
                let doc = try SwiftSoup.parse(html)
                let groupContent = try doc.select("section.content-area.default-format")
                let groupLinks = try groupContent.select("a")
                
                for groupLink in groupLinks.array() {
                    let name = try groupLink.text()
                    let link = try groupLink.attr("href")
                    
                    DispatchQueue.main.async {
                        self.groups.append(Group(name: name, url: link))
                    }
                }
                
            }  catch let error as NSError {
                print("Error: \(error.localizedDescription)")
            }
            
        }
    }
}