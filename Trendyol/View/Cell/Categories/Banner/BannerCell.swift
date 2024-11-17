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
    
    func configureBan(with banner: Banner) {
        
        imgBanner.image = UIImage(named: "banner3")
        
        imgBanner.layer.cornerRadius = 10
        imgBanner.layer.masksToBounds = true
    }
    
    func configureBrand(with brand: Product) {
        imgBanner.layer.cornerRadius = 0
        imgBanner.layer.masksToBounds = true
        imgBanner.image = UIImage(named: brand.brandImg)
    }
    
    func configureDefault() {
        imgBanner.image = UIImage(named: "default_banner")
    }
}
