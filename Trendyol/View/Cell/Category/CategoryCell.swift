//
//  CategoryCell.swift
//  Trendyol
//
//  Created by IREM SEVER on 5.11.2024.
//

import UIKit

class CategoryCell: UICollectionViewCell {
    @IBOutlet weak var viewBg: UIView!
    @IBOutlet weak var lblCategory: UILabel!
    @IBOutlet weak var viewButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configuration(home: Category) {
        //        viewBg.backgroundColor = UIColor
        lblCategory.text = home.name
        
    }

}
