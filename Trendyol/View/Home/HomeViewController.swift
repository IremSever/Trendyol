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
    private var selectedCategoryIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionViews()
        loadData()
        didSelectCategory(at: 0)
    }
    
    private func setupCollectionViews() {
        collectionViewCategories.delegate = self
        collectionViewCategories.dataSource = self
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionViewCategories.collectionViewLayout = createLayoutForCategories()
        collectionView.collectionViewLayout = createLayoutForProducts()
        
        registerCells()
    }
    
    func registerCells() {
        collectionViewCategories.register(UINib(nibName: "CategoryCell", bundle: nil), forCellWithReuseIdentifier: "CategoryCell")
        
        collectionView.register(UINib(nibName: "BannerCell", bundle: nil), forCellWithReuseIdentifier: "BannerCell")
        collectionView.register(UINib(nibName: "ServicesCell", bundle: nil), forCellWithReuseIdentifier: "ServicesCell")
        collectionView.register(UINib(nibName: "CouponCell", bundle: nil), forCellWithReuseIdentifier: "CouponCell")
        collectionView.register(UINib(nibName: "ProductCell", bundle: nil), forCellWithReuseIdentifier: "ProductCell")
        collectionView.register(UINib(nibName: "PromotionCell", bundle: nil), forCellWithReuseIdentifier: "PromotionCell")
        
        collectionView.register(UINib(nibName: "CategoryHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "CategoryHeaderView")
    }
    
    private func loadData() {
        viewModel.loadHomeData { [weak self] in
            DispatchQueue.main.async {
                self?.collectionViewCategories.reloadData()
                self?.collectionView.reloadData()
                
                self?.didSelectCategory(at: 0)
            }
        }
    }
    
    private func createLayoutForCategories() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            let section: NSCollectionLayoutSection
            
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.20), heightDimension: .absolute(25))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(30))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 5)
            
            
            section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .continuous
            
            return section
        }
        return layout
    }
    
    private func createLayoutForProducts() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            let section: NSCollectionLayoutSection
            
            switch sectionIndex {
            case 0:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(100))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(100))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .paging
            case 1:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.20), heightDimension: .absolute(88))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 0, trailing: 8)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(88))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 6)
                section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
            case 2:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(50))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 0, trailing: 8)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(50))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .paging
            case 3:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(270))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 0, trailing: 8)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(270))
                let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
                
                section = NSCollectionLayoutSection(group: group)
            case 4:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .absolute(80))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 0, trailing: 8)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(80))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 2)
                section = NSCollectionLayoutSection(group: group)
                //-------------------------------
            case 5:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(240))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(240))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                
            case 6:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(100))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(350))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                
            case 7:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(350))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(350))
                let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
                section = NSCollectionLayoutSection(group: group)
                
            case 8:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(350))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(350))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                
            case 9:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(350))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(350))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                
            default:
                return nil
            }
            
            return section
        }
        return layout
    }
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionViewCategories {
            return viewModel.getCategories().count
        } else {
            switch section {
            case 0: return viewModel.getBanners().count
            case 1: return viewModel.getServices().count
            case 2, 3: return 1 /*viewModel.getBanners().count*/
            case 4: return viewModel.getCoupons().count
            case 5: return 1
//                let selectedCategory = viewModel.getCategories()[selectedCategoryIndex]
//                return viewModel.getProductsGroupedByCategory(categoryName: selectedCategory.name ?? "").count
           
            default: return 1
                
            }
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if collectionView == collectionViewCategories {
            return 1
        } else {
            return 10
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collectionViewCategories {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as! CategoryCell
                let category = viewModel.categoriesCellForRowAt(indexPath: indexPath)
                cell.configure(with: category, isInitiallySelected: indexPath.row == selectedCategoryIndex)
                cell.delegate = self
                cell.index = indexPath.row
                return cell
           
        } else {
            var product: Product?
            switch indexPath.section {
            case 0:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BannerCell", for: indexPath) as! BannerCell
                let banner = viewModel.bannerCellForRowAt(indexPath: indexPath)
                cell.configure(with: banner)
                return cell
                
            case 1:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ServicesCell", for: indexPath) as! ServicesCell
                let service = viewModel.serviceCellForRowAt(indexPath: indexPath)
                cell.configure(with: service)
                return cell
            case 2:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BannerCell", for: indexPath) as! BannerCell
                let banner = viewModel.bannerCellForRowAt(indexPath: indexPath)
                cell.configure(with: banner)
                return cell
            case 3:
                let flashProducts = viewModel.getFlashSaleProducts()
                guard indexPath.row < flashProducts.count else {
                    print("Invalid index for flash sale products.")
                    return UICollectionViewCell()
                }
                product = flashProducts[indexPath.row]
                if let product = product {
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PromotionCell", for: indexPath) as! PromotionCell
                    cell.configure(with: product)
                    return cell
                } else {
                    return UICollectionViewCell()
                }
            case 4:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CouponCell", for: indexPath) as! CouponCell
                let coupon = viewModel.couponCellForRowAt(indexPath: indexPath)
                cell.configure(with: coupon)
                return cell
                
            case 5:
                let promotionalProducts = viewModel.getPromotionalProducts()
                guard indexPath.row < promotionalProducts.count else {
                    print("Invalid index for promotional products.")
                    return UICollectionViewCell()
                }
                product = promotionalProducts[indexPath.row]
                //-------------------------------
                
            case 6:
                let productsInBrand = viewModel.getGroupedProductsByBrand()
                guard indexPath.row < productsInBrand.count, let firstProduct = productsInBrand[indexPath.row].first else {
                    print("No products available in this brand.")
                    return UICollectionViewCell()
                }
                product = firstProduct
                
            case 7:
                let promotionalProducts = viewModel.getPromotionalProducts()
                guard indexPath.row < promotionalProducts.count else {
                    print("Invalid index for promotional products.")
                    return UICollectionViewCell()
                }
                product = promotionalProducts[indexPath.row]
                //-------------------------------
                
            case 8, 9:
                let promotionalProducts = viewModel.getPromotionalProducts()
                guard indexPath.row < promotionalProducts.count else {
                    print("Invalid index for promotional products.")
                    return UICollectionViewCell()
                }
                product = promotionalProducts[indexPath.row]
            
                
            default:
                fatalError("Unexpected section in collectionView.")
            }
            
            if let product = product, (product.flashSale || product.isPromotion) {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PromotionCell", for: indexPath) as! PromotionCell
                cell.configure(with: product)
                return cell
            } else if let product = product {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as! ProductCell
                cell.configure(with: product)
                return cell
            } else {
                return UICollectionViewCell()
            }
        }
    }
    
//    
//    
//    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//        if kind == UICollectionView.elementKindSectionHeader {
//            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "CategoryHeaderView", for: indexPath) as! CategoryHeaderCell
//            switch indexPath.section {
//            case 0:
//                header.lblHeader.text = "Kategoriye Göre Ürünler"
//            case 1:
//                header.lblHeader.text = "Markaya Göre Ürünler"
//            case 2:
//                header.lblHeader.text = "Promosyonlar"
//            default:
//                break
//            }
//            return header
//        }
//        return UICollectionReusableView()
//    }
//    
    func loadProductForSelectedCategory(index: Int, animated: Bool = true) {
        viewModel.setSelectedCategoryIndex(index) 
        if animated {
            let direction: CGFloat = index > selectedCategoryIndex ? 1 : -1
            let originalTransform = collectionView.transform
            
            collectionView.transform = CGAffineTransform(translationX: direction * collectionView.frame.width, y: 0)
            
            UIView.animate(withDuration: 0.5, animations: {
                self.collectionView.reloadData()
                self.collectionView.transform = originalTransform
            })
        } else {
            collectionView.reloadData()
        }
    }

    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == collectionViewCategories && indexPath.section == 1 {
            loadProductForSelectedCategory(index: indexPath.row, animated: true)
            collectionViewCategories.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
    
    func didSelectCategory(at index: Int) {
        let indexPath = IndexPath(item: index, section: 0)
        collectionViewCategories.selectItem(at: indexPath, animated: true, scrollPosition: [])
        collectionView(collectionViewCategories, didSelectItemAt: indexPath)

        loadProductForSelectedCategory(index: index)
    }
}
