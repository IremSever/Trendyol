//
//  BannerCell.swift
//  Trendyol
//
//  Created by IREM SEVER on 5.11.2024.
//

import UIKit

class BannerCell: UICollectionViewCell {
    
    @IBOutlet weak var imgBanner: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(with banner: Banner) {
        if let imageName = banner.image {
            imgBanner.image = UIImage(named: imageName)
        } else {
            imgBanner.image = UIImage(named: "default_product_image")
        }
        imgBanner.layer.cornerRadius = 20
        imgBanner.layer.masksToBounds = true
    }
    
}
