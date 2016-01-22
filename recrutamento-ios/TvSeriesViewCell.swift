//
//  TvSeriesViewCell.swift
//  recrutamento-ios
//
//  Created by Vinicius Carvalho on 20/01/16.
//  Copyright © 2016 Vinicius Carvalho. All rights reserved.
//

import UIKit
import AlamofireImage

class TvSeriesViewCell: UICollectionViewCell {
    
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var imageTvSeries: UIImageView!
    
    func useThumbImage(imageURL: NSString) {
        
        showThumb.af_setImageWithUrl (NSURL(string: imageURL as String)!,
            placeholderImage:UIImage(named: "imageLoad"))
    }
    
}
