//
//  CategoryHeaderCell.swift
//  Trendyol
//
//  Created by İrem Sever on 11.11.2024.
//

import UIKit

class CategoryHeaderCell: UICollectionReusableView {

    @IBOutlet weak var lblHeader: UILabel!
    @IBOutlet weak var viewBg: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func configure(with categoryTitle: String, backgroundColor: UIColor) {
           lblHeader.text = categoryTitle
           viewBg.backgroundColor = backgroundColor
       }
    
}
