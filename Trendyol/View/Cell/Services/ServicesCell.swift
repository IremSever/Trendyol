//
//  ServicesCell.swift
//  Trendyol
//
//  Created by IREM SEVER on 11.11.2024.
//

import UIKit

class ServicesCell: UICollectionViewCell {

    @IBOutlet weak var imgService: UIImageView!
    @IBOutlet weak var lblService: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func configure(with service: Service) {
        lblService.text = service.name
        if let imageName = service.icon {
            imgService.image = UIImage(named: imageName)
        } else {
            imgService.image = UIImage(named: "default_product_image")
        }
    }
    
}
