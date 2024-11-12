//
//  PromotionCellCollectionViewCell.swift
//  Trendyol
//
//  Created by İrem Sever on 11.11.2024.
//

import UIKit

class PromotionCell: UICollectionViewCell, UICollectionViewDataSource, UICollectionViewDelegate {
    private var viewModel = HomeViewModel()
    @IBOutlet weak var collectionViewProduct: UICollectionView!
    @IBOutlet weak var lblSeconds: UILabel!
    @IBOutlet weak var lblMinute: UILabel!
    @IBOutlet weak var lblHour: UILabel!
    @IBOutlet weak var viewStackTimer: UIStackView!
    @IBOutlet weak var collectionViewCategory: UICollectionView!
    @IBOutlet weak var viewBg: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        loadData()
    }
    
    func loadData() {
        collectionViewProduct.dataSource = self
        collectionViewProduct.delegate = self
        
        collectionViewCategory.dataSource = self
        collectionViewCategory.delegate = self
    }

    func registerCell() {
        collectionViewCategory.register(UINib(nibName: "CategoryCell", bundle: nil), forCellWithReuseIdentifier: "CategoryCell")
        
        collectionViewProduct.register(UINib(nibName: "ProductCell", bundle: nil), forCellWithReuseIdentifier: "ProductCell")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.homeData?.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        <#code#>
    }
}
