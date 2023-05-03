import Foundation

class APIService {
    
    var url: String = ""
    
    init(url: String) {
        self.url = url
    }
    
    func getHTML(completion: @escaping (String?) -> Void) {
        guard let url = URL(string: url) else {
            print("Invalid URL")
            completion(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching HTML: \(error.localizedDescription)")
                completion(nil)
                return
            }
                    
            guard let data = data else {
                print("Data is missing.")
                completion(nil)
                return
            }
                    
            if let html = String(data: data, encoding: .utf8) {
                completion(html)
            } else {
                print("Unable to convert data to text.")
                completion(nil)
            }
        }
                
        task.resume()
    }
}
