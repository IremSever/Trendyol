//
//  CouponCell.swift
//  Trendyol
//
//  Created by IREM SEVER on 5.11.2024.
//

import UIKit

class CouponCell: UICollectionViewCell {

    @IBOutlet weak var imgCoupon: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    func configure(with coupon: Coupon) {
        
        
        if let imageName = coupon.icon {
            imgCoupon.image = UIImage(named: imageName)
        } else {
            imgCoupon.image = UIImage(named: "default_product_image")
        }
        
    }
    
}
