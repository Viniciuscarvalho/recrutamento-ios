
import UIKit
import AlamofireImage

class TvSeriesViewCell: UICollectionViewCell {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var imageTvSeries: UIImageView!
    
    func useThumbImage(imageURL: NSString) {
        
        imageTvSeries.af_setImageWithURL(NSURL(string: imageURL as String!)!,
            placeholderImage:UIImage(named: "imageLoad"))
    }
    
}
