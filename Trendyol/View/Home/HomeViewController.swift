//
//  ViewController.swift
//  Trendyol
//
//  Created by IREM SEVER on 5.11.2024.
//

import UIKit

class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, CategorySelectionDelegate {
    @IBOutlet weak var collectionViewCategories: UICollectionView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var viewModel = HomeViewModel()
    
    private var categories: [Category] = []
    private var itemsForSelectedCategory: [Product] = []
    private var selectedCategoryIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionViews()
        loadCategories()
        
        let firstIndexPath = IndexPath(item: 0, section: 0)
        collectionViewCategories.selectItem(at: firstIndexPath, animated: false, scrollPosition: [])
        //            collectionViewCategories(collectionViewCategories, didSelectItemAt: firstIndexPath)
    }
    
    private func setupCollectionViews() {
        // Delegate ve DataSource atamaları
        collectionViewCategories.delegate = self
        collectionViewCategories.dataSource = self
        collectionView.delegate = self
        collectionView.dataSource = self
        
        registerCells()
    }
    
    func registerCells() {
        // Hücreleri iki koleksiyon görünümü için de kaydediyoruz
        collectionViewCategories.register(UINib(nibName: "CategoryCell", bundle: nil), forCellWithReuseIdentifier: "CategoryCell")
        collectionView.register(UINib(nibName: "ContentCell", bundle: nil), forCellWithReuseIdentifier: "ContentCell")
    }
    
    private func loadCategories() {
        // Kategori verilerini yükleme
        viewModel.loadHomeData()
        if let loadedCategories = viewModel.getCategories() {
            self.categories = loadedCategories
            self.collectionViewCategories.reloadData()
            loadContentForSelectedCategory(index: 0)
        }
    }
    
    private func loadContentForSelectedCategory(index: Int, animated: Bool = true) {
        let selectedCategory = categories[index]

        // Animasyon ile geçiş
        if animated {
            // Kaydırma yönünü belirle
            let direction: CGFloat = index > selectedCategoryIndex ? 1 : -1
            
            // Önceki içerikleri kaydırma işlemi (soldan sağa veya sağdan sola)
            UIView.animate(withDuration: 0.5, animations: {
                // Sağdan sola kayma (index > selectedCategoryIndex)
                self.collectionView.transform = CGAffineTransform(translationX: direction * self.collectionView.frame.width, y: 0)
            }, completion: { _ in
                // Yeni içerik yükleme
//                self.itemsForSelectedCategory = self.viewModel.getContentForCategory(selectedCategory)
                self.collectionView.reloadData()  // İçeriği yeniden yükle
                
                // Kategori değişimi sonrası index yazdır
                print("CollectionView's content has been changed. Current Index: \(self.selectedCategoryIndex)")
                
                // Koleksiyonu eski haline getirme
                UIView.animate(withDuration: 0.5) {
                    self.collectionView.transform = CGAffineTransform.identity
                }
            })
        } else {
            // Animasyon olmadan içerik değişimi
//            self.itemsForSelectedCategory = self.viewModel.getContentForCategory(selectedCategory)
            self.collectionView.reloadData()
            
            // Kategori değişimi sonrası index'i yazdır
            print("CollectionView's content has been changed. Current Index: \(self.selectedCategoryIndex)")
        }
    }

    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionViewCategories {
            return categories.count
        } else {
            return itemsForSelectedCategory.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collectionViewCategories {
            // Kategori hücre yapılandırması
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as! CategoryCell
            let category = categories[indexPath.row]
            cell.configure(with: category, isInitiallySelected: indexPath.row == selectedCategoryIndex)
            cell.delegate = self
            cell.index = indexPath.row
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as! ProductCell
            let contentItem = itemsForSelectedCategory[indexPath.row]
            //                cell.configure(with: contentItem)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == collectionViewCategories {
            selectedCategoryIndex = indexPath.row
            loadContentForSelectedCategory(index: selectedCategoryIndex, animated: true)
            
            print("Selected Category Index: \(selectedCategoryIndex)")
            
            collectionViewCategories.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == collectionViewCategories {
            return CGSize(width: collectionView.frame.width / 3, height: collectionView.frame.height)
        } else {
            return CGSize(width: collectionView.frame.width, height: 150)
        }
    }
    
    func didSelectCategory(at index: Int) {
        let indexPath = IndexPath(item: index, section: 0)
        collectionViewCategories.selectItem(at: indexPath, animated: true, scrollPosition: [])
        collectionView(collectionViewCategories, didSelectItemAt: indexPath)
    }
    
    
}
