//
//  PromotionCellCollectionViewCell.swift
//  Trendyol
//
//  Created by İrem Sever on 11.11.2024.
//

import UIKit

class PromotionCell: UICollectionViewCell, UICollectionViewDataSource, UICollectionViewDelegate, ProductCategorySelectionDelegate {
    private var viewModel = HomeViewModel()
    @IBOutlet weak var titleCell: UILabel!
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
        setupCollectionViews()
        loadData()
    }
    
    private func setupCollectionViews() {
        collectionViewProduct.dataSource = self
        collectionViewProduct.delegate = self
        collectionViewCategory.dataSource = self
        collectionViewCategory.delegate = self
        
         registerCell()
    }
    func loadData() {
        viewModel.loadHomeData { [weak self] in
            DispatchQueue.main.async {
                self?.collectionViewCategory.reloadData()
                self?.collectionViewProduct.reloadData()
                self?.updateVisibilityBasedOnConditions()
                if ((self?.isFlashProduct) != nil) {
                    self?.startTimer()
                }
                self?.didSelectProductCategory(at: 0)
            }
        }
    }
    
    func registerCell() {
        collectionViewCategory.register(UINib(nibName: "CategoryCell", bundle: nil), forCellWithReuseIdentifier: "CategoryCell")
        collectionViewProduct.register(UINib(nibName: "ProductCell", bundle: nil), forCellWithReuseIdentifier: "ProductCell")
    }
    func updateVisibilityBasedOnConditions() {
        if isFlashProduct {
            titleCell.text = "Flaş Ürünler"
            titleCell.isHidden = false
        } else if isPromotion {
            titleCell.text = "Promosyonlu Ürünler"
            titleCell.isHidden = false
        } else {
            titleCell.isHidden = true
        }

        viewStackTimer.isHidden = !isFlashProduct
        collectionViewCategory.isHidden = !isPromotion || isFlashProduct
        heightCategory.constant = isPromotion ? 32 : 0
        heightProducts.constant = isPromotion ? 288 : 312
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
            
            cell.configure(with: categoryName, isInitiallySelected: indexPath.row == selectedCategoryIndex)
            
            cell.delegateProduct = self
            cell.index = indexPath.row
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as! ProductCell
            var product: Product
            cell.layer.cornerRadius = 20
            cell.layer.borderWidth = 0.5
            cell.layer.borderColor = UIColor.lightGray.cgColor
            cell.layer.masksToBounds = true
            if isFlashProduct {
                heightProducts.constant = 280
                product = viewModel.getFlashSaleProducts()[indexPath.row]
            } else if isPromotion {
                heightProducts.constant = 280
                product = viewModel.getPromotionalProducts()[indexPath.row]
            } else if isPreviouslyViewed {
                heightProducts.constant = 312
                product = viewModel.getPreviouslyViewedProducts()[indexPath.row]
            } else {
                heightProducts.constant = 312
                product = viewModel.getSelectedCategoryProducts()[indexPath.row]
            }
            
            cell.configure(with: product)
            return cell
        }
    }

    func didSelectProductCategory(at index: Int) {
        
        selectedCategoryIndex = index
        viewModel.setSelectedCategoryIndex(index)
        
        collectionViewProduct.reloadData()
        
        let indexPath = IndexPath(item: index, section: 0)
        collectionViewCategory.selectItem(at: indexPath, animated: true, scrollPosition: [])
   
    }
 
 
}
