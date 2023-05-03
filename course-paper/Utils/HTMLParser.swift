import SwiftSoup
import Foundation

class HTMLParser {
    static func getTextWithLineBreaks(element: Element) -> String {
        do {
            let breakpoint = try element.select("br")
            
            try breakpoint.forEach { br in
                try br.replaceWith(TextNode(Constants.separator, ""))
            }
            
            return try element.text()
            
        } catch Exception.Error(let type, let message) {
            print(message)
        } catch {
            print(error)
        }
        
        return ""
    }
}
