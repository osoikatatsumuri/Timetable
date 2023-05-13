import Foundation

class APIService {
    
    var url: String = ""
    
    init(url: String) {
        self.url = url
    }
    
    func getHTML() async throws -> String {
        guard let url = URL(string: url) else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        if let html = String(data: data, encoding: .utf8) {
            return html
        } else {
            throw NSError(domain: "Unable to convert data to text", code: 1)
        }
    }
    
    
}
