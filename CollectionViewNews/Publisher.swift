

import UIKit

class Publisher
{
    var title: String
    var url: String
    var image: UIImage
    var section: String
    
    init(title: String, url: String, image: UIImage, section: String)
    {
        self.title = title
        self.url = url
        self.image = image
        self.section = section
    }
    
    convenience init(copies publisher: Publisher)
    {
        self.init(title: publisher.title, url: publisher.url, image: publisher.image, section: publisher.section)
    }
}


