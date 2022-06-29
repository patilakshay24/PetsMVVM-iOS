
import Foundation

struct Pet {
    let image_url: String
    let title: String
    let content_url: String
    let date_added: String
    
    init(_ image_url: String, _ title: String, _ content_url: String, _ date_added: String) {
        self.image_url = image_url
        self.title = title
        self.content_url = content_url
        self.date_added = date_added
    }
}
