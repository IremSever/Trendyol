//
//  ProductCell.swift
//  Trendyol
//
//  Created by IREM SEVER on 5.11.2024.
//

import UIKit

class ProductCell: UICollectionViewCell {
   
    @IBOutlet weak var lblReviews: UILabel!
    @IBOutlet weak var lblRating: UILabel!
    
    
    @IBOutlet weak var stackViewStar: UIStackView!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblProduct: UILabel!
    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet weak var viewBg: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
     
    }
    
    func configure(with product: Product) {
        lblProduct.text = product.brand + product.description
        lblPrice.text = String(product.price)
        
        configureStars(rating: product.rating)
        
        if let imageName = product.image {
            imgProduct.image = UIImage(named: imageName)
        } else {
            imgProduct.image = UIImage(named: "default_product_image")
        }
        
        imgProduct.layer.cornerRadius = 30
        imgProduct.layer.masksToBounds = true
        lblRating.text = String(product.rating)
        lblReviews.text = "(\(String(product.reviewsCount)))"
        
    }
    
    func configureStars(rating: Double) {
        for (index, view) in stackViewStar.arrangedSubviews.enumerated() {
            if let star = view as? UIImageView {
                let starIndex = Double(index + 1)
                
                if rating >= starIndex {
                    star.image = UIImage(systemName: "star.fill")
                } else if rating >= starIndex - 0.5 {
                    star.image = UIImage(systemName: "star.leadinghalf.filled")
                } else {
                    star.image = UIImage(systemName: "star")
                }
            }
        }
    }
}
