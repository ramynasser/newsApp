
import UIKit



protocol CollectionViewCellDelegate{
    func deletePublisher(publisher: Publisher)
}


class CollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var publisherImageView: UIImageView!
    @IBOutlet weak var VisualEffectView: UIVisualEffectView!
    @IBOutlet weak var PublisherTitleLabel: UILabel!
    var delegate: CollectionViewCellDelegate?

    
    var editing: Bool = false {
        didSet {
            closeButtonView.hidden = !editing
        }
    }
    
    @IBOutlet weak var closeButtonView: UIButton!
    var publisher:Publisher?{
        didSet{
        UpdateUI()
        }
    
    }
    
    @IBAction func deleteButtonClicked(sender: AnyObject) {
        delegate?.deletePublisher(publisher!)
    }
    func UpdateUI()  {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 3.0
        publisherImageView.image=publisher?.image
        PublisherTitleLabel.textAlignment = .Center
        PublisherTitleLabel.text=publisher?.title
        
        closeButtonView.layer.masksToBounds = true
        closeButtonView.layer.cornerRadius = closeButtonView.bounds.width / 2    }
}
