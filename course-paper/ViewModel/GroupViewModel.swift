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
                let groupContainer = doc.select("div.content-area-default-format")
                
            } catch Exception.error(let type, let message) {
                print(message)
            } catch {
                print(Constants.genericErrorMessage)
            }
            
        }
    }
}
