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
        loadData()
    }
    
    private func setupCollectionViews() {
        collectionViewCategories.delegate = self
        collectionViewCategories.dataSource = self
        collectionView.delegate = self
        collectionView.dataSource = self
        
        registerCells()
    }
    
    func registerCells() {
        //           collectionViewCategories.register(UINib(nibName: "SearchCell", bundle: nil), forCellWithReuseIdentifier: "SearchCell")
        collectionViewCategories.register(UINib(nibName: "CategoryCell", bundle: nil), forCellWithReuseIdentifier: "CategoryCell")
        collectionView.register(UINib(nibName: "ProductCell", bundle: nil), forCellWithReuseIdentifier: "ProductCell")
    }
    
    private func loadData() {
        viewModel.loadHomeData { [weak self] in
            DispatchQueue.main.async {
                self?.collectionViewCategories.reloadData()
                self?.collectionView.reloadData()
            }
        }
    }
    
    private func loadContentForSelectedCategory(index: Int, animated: Bool = true) {
        guard categories.count > index else { return }
        let selectedCategory = categories[index]
        
        itemsForSelectedCategory = selectedCategory.products
        
        if animated {
            let direction: CGFloat = index > selectedCategoryIndex ? 1 : -1
            
            UIView.animate(withDuration: 0.5, animations: {
                self.collectionView.transform = CGAffineTransform(translationX: direction * self.collectionView.frame.width, y: 0)
            }, completion: { _ in
                self.collectionView.reloadData()
                UIView.animate(withDuration: 0.5) {
                    self.collectionView.transform = CGAffineTransform.identity
                }
            })
        } else {
            self.collectionView.reloadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionViewCategories {
            print(viewModel.categoriesNumberOfRowsInSection(section: section))
            return viewModel.categoriesNumberOfRowsInSection(section: section)
        } else {
            return itemsForSelectedCategory.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collectionViewCategories {
            let category = viewModel.categoriesCellForRowAt(indexPath: indexPath)
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as! CategoryCell
            cell.configure(with: category, isInitiallySelected: indexPath.row == selectedCategoryIndex)
            cell.delegate = self
            cell.index = indexPath.row
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as! ProductCell
            let contentItem = itemsForSelectedCategory[indexPath.row]
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == collectionViewCategories {
            selectedCategoryIndex = indexPath.row
            loadContentForSelectedCategory(index: selectedCategoryIndex, animated: true)
            
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
