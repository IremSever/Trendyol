//
//  CategoryCell.swift
//  Trendyol
//
//  Created by IREM SEVER on 5.11.2024.
//

import UIKit

protocol CategorySelectionDelegate: AnyObject {
    func didSelectCategory(at index: Int)
}

class CategoryCell: UICollectionViewCell {
    @IBOutlet weak var viewBg: UIView!
    @IBOutlet weak var lblCategory: UILabel!
    @IBOutlet weak var viewButton: UIButton!
    weak var delegate: CategorySelectionDelegate?
    var index: Int?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewBg.layer.cornerRadius = 10
        viewBg.layer.masksToBounds = true
        
        viewButton.layer.cornerRadius = 10
        viewButton.layer.masksToBounds = true
        viewButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    func configure(with category: Category, isInitiallySelected: Bool = false) {
        lblCategory.text = category.name
        if let colorHex = category.backgroundColor {
            viewBg.backgroundColor = UIColor(named: colorHex)
        } else {
            viewBg.backgroundColor = .gray
        }
        
        self.isSelected = isInitiallySelected
        updateSelectionStyle()
    }
    
    override var isSelected: Bool {
        didSet {
            updateSelectionStyle()
        }
    }
    
    private func updateSelectionStyle() {
        if isSelected {
            viewButton.backgroundColor = .orange
            viewButton.layer.borderWidth = 0
            lblCategory.textColor = .white
        } else {
            viewButton.backgroundColor = .white
            viewButton.layer.borderWidth = 1
            viewButton.layer.borderColor = UIColor.lightGray.cgColor
            lblCategory.textColor = .black
        }
    }
    
    @objc private func buttonTapped() {
        if let index = index {
            delegate?.didSelectCategory(at: index)
        }
    }
}
