//
//  PromotionCellCollectionViewCell.swift
//  Trendyol
//
//  Created by İrem Sever on 11.11.2024.
//

import UIKit

class PromotionCell: UICollectionViewCell, UICollectionViewDataSource, UICollectionViewDelegate, ProductCategorySelectionDelegate {
    private var viewModel = HomeViewModel()
    @IBOutlet weak var collectionViewProduct: UICollectionView!
    @IBOutlet weak var lblSeconds: UILabel!
    @IBOutlet weak var lblMinute: UILabel!
    @IBOutlet weak var lblHour: UILabel!
    @IBOutlet weak var viewStackTimer: UIStackView!
    @IBOutlet weak var collectionViewCategory: UICollectionView!
    @IBOutlet weak var viewBg: UIView!
    var selectedCategoryIndex: Int = 0
    var isFlashProduct: Bool = false
    var isPromotion: Bool = false
    var isPreviouslyViewed: Bool = false
    
    @IBOutlet weak var heightProducts: NSLayoutConstraint!
    @IBOutlet weak var heightCategory: NSLayoutConstraint!
    var timer: Timer?
    var totalTime: TimeInterval = 3 * 60 * 60
    var remainingTime: TimeInterval = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        loadData()
    }
    
    func loadData() {
        collectionViewProduct.dataSource = self
        collectionViewProduct.delegate = self
        collectionViewCategory.dataSource = self
        collectionViewCategory.delegate = self
        
        registerCell()
        
        viewModel.loadHomeData {
            self.collectionViewCategory.reloadData()
            self.collectionViewProduct.reloadData()
            self.updateVisibilityBasedOnConditions()
            if self.isFlashProduct {
                self.startTimer()
            }
        }
    }
    
    func registerCell() {
        collectionViewCategory.register(UINib(nibName: "CategoryCell", bundle: nil), forCellWithReuseIdentifier: "CategoryCell")
        collectionViewProduct.register(UINib(nibName: "ProductCell", bundle: nil), forCellWithReuseIdentifier: "ProductCell")
    }
    
    func updateVisibilityBasedOnConditions() {
        viewStackTimer.isHidden = !isFlashProduct
        collectionViewCategory.isHidden = isFlashProduct || isPreviouslyViewed
    }
    func startTimer() {
        guard isFlashProduct, timer == nil else { return }
        remainingTime = totalTime
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        remainingTime -= 1
        
        let hours = Int(remainingTime) / 3600
        let minutes = (Int(remainingTime) % 3600) / 60
        let seconds = Int(remainingTime) % 60
        
        lblHour.text = String(format: "%02d", hours)
        lblMinute.text = String(format: "%02d", minutes)
        lblSeconds.text = String(format: "%02d", seconds)
        
        if remainingTime <= 0 {
            timer?.invalidate()
            timer = nil
            remainingTime = 0
            print("Flash product timer finished")
        }
    }
    
    func configure(with product: Product) {
        self.isFlashProduct = product.flashSale
        self.isPromotion = product.isPromotion
        self.isPreviouslyViewed = product.previouslyViewed ?? true
        
        
        updateVisibilityBasedOnConditions()
        
        if isFlashProduct {
            startTimer()
        } else {
            timer?.invalidate()
            timer = nil
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionViewCategory {
            return viewModel.getProductCategories().count
        } else {
            if isFlashProduct {
                return viewModel.getFlashSaleProducts().count
            } else if isPromotion {
                return viewModel.getPromotionalProducts().count
            } else if isPreviouslyViewed {
                return viewModel.getPreviouslyViewedProducts().count
            } else {
                return viewModel.getSelectedCategoryProducts().count
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collectionViewCategory {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as! CategoryCell
            let categoryName = viewModel.getProductCategories()[indexPath.row]
            
            // Configure the cell with the unique category name
            cell.configure(with: categoryName)
            cell.delegateProduct = self
            cell.index = indexPath.row
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as! ProductCell
            var product: Product
            
            if isFlashProduct {
                heightCategory.constant = 0
                heightProducts.constant = 250
                product = viewModel.getFlashSaleProducts()[indexPath.row]
            } else if isPromotion {
                heightCategory.constant = 32
                heightProducts.constant = 250
                product = viewModel.getPromotionalProducts()[indexPath.row]
            } else if isPreviouslyViewed {
                heightCategory.constant = 0
                heightProducts.constant = 282
                product = viewModel.getPreviouslyViewedProducts()[indexPath.row]
            } else {
                heightCategory.constant = 0
                heightProducts.constant = 282
                product = viewModel.getSelectedCategoryProducts()[indexPath.row]
            }
            
            cell.configure(with: product)
            return cell
        }
    }

    
    func didSelectProductCategory(at index: Int) {
        let indexPath = IndexPath(item: index, section: 0)
        collectionViewCategory.selectItem(at: indexPath, animated: true, scrollPosition: [])
        collectionView(collectionViewCategory, cellForItemAt: indexPath)
    }
}
