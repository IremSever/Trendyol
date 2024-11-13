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
               self.updateVisibilityBasedOnConditions() // Update visibility after loading data
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
           // Check if the product is a flash sale
           if isFlashProduct {
               collectionViewCategory.isHidden = true // Hide categories for flash sale
               viewStackTimer.isHidden = false // Show timer for flash sale
           } else {
               collectionViewCategory.isHidden = false // Show categories for non-flash sale
               viewStackTimer.isHidden = true // Hide timer for non-flash sale
           }
           
           // Check if the product is a promotion
           if isPromotion {
               viewStackTimer.isHidden = true // Hide the timer for promotional products
           }
           
           // If the product has already been viewed, hide the timer
           if isPreviouslyViewed {
               viewStackTimer.isHidden = true
           }
       }
       
       func startTimer() {
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
               print("Flash product timer finished")
           }
       }
       
       func configure(with product: Product) {
           // Set flags based on the product type
           if product.flashSale {
               self.isFlashProduct = true
           } else {
               self.isFlashProduct = false
           }

           if product.isPromotion {
               self.isPromotion = true // Set as promotion if applicable
           } else {
               self.isPromotion = false
           }
           
           if isFlashProduct {
               startTimer()
           }
       }
       
       func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
           if collectionView == collectionViewCategory {
               return viewModel.getCategories().count
           } else {
               // Return flash sale products or promotional products based on the condition
               return isFlashProduct ? viewModel.getFlashSaleProducts().count : viewModel.getPromotionalProducts().count
           }
       }
       
       func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
           if collectionView == collectionViewCategory {
               let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as! CategoryCell
               let category = viewModel.getCategories()[indexPath.row]
               cell.configure(with: category)
               cell.delegateProduct = self
               cell.index = indexPath.row
               return cell
           } else {
               let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as! ProductCell
               let products = isFlashProduct ? viewModel.getFlashSaleProducts() : viewModel.getPromotionalProducts()
               let product = products[indexPath.row]
               cell.configure(with: product)
               return cell
           }
       }
       
       func didSelectProductCategory(at index: Int) {
           let category = viewModel.getCategories()[index]
           print("Selected Category: \(category.name ?? "Unknown")")
           
           let selectedCategoryProducts = viewModel.getProductCategory(forCategory: category.name ?? "")
           print("Filtered Products: \(selectedCategoryProducts)")
       }
   }
