//
//  ViewController.swift
//  Trendyol
//
//  Created by IREM SEVER on 5.11.2024.
//

import UIKit

class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, CategorySelectionDelegate {
    @IBOutlet weak var collectionViewMain: UICollectionView!
    @IBOutlet weak var collectionViewCategories: UICollectionView!
    @IBOutlet weak var collectionView: UICollectionView!
    private var viewModel = HomeViewModel()
    private var selectedCategoryIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionViews()
        loadData()
    }
    
    private func setupCollectionViews() {
        collectionViewMain.isScrollEnabled = true
        collectionViewCategories.delegate = self
        collectionViewCategories.dataSource = self
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionViewCategories.isScrollEnabled = false
        
        collectionViewCategories.collectionViewLayout = createLayoutForCategories()
        collectionView.collectionViewLayout = createLayoutForProducts()
        
        registerCells()
    }
    
    func registerCells() {
        collectionViewCategories.register(UINib(nibName: "SearchBarCell", bundle: nil), forCellWithReuseIdentifier: "SearchBarCell")
        collectionViewCategories.register(UINib(nibName: "CategoryCell", bundle: nil), forCellWithReuseIdentifier: "CategoryCell")
        collectionViewCategories.register(UINib(nibName: "BannerCell", bundle: nil), forCellWithReuseIdentifier: "BannerCell")
        collectionViewCategories.register(UINib(nibName: "ServicesCell", bundle: nil), forCellWithReuseIdentifier: "ServicesCell")
        collectionViewCategories.register(UINib(nibName: "CouponCell", bundle: nil), forCellWithReuseIdentifier: "CouponCell")
        
        collectionView.register(UINib(nibName: "ProductCell", bundle: nil), forCellWithReuseIdentifier: "ProductCell")
        collectionView.register(UINib(nibName: "CategoryHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "CategoryHeaderView")
    }
    
    private func loadData() {
        viewModel.loadHomeData { [weak self] in
            DispatchQueue.main.async {
                self?.collectionViewCategories.reloadData()
                self?.collectionView.reloadData()
            }
        }
    }
    
    private func createLayoutForCategories() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            let section: NSCollectionLayoutSection
            switch sectionIndex {
            case 0:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(60))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(60))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 1)
                section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
            case 1:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.25), heightDimension: .absolute(45))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(35))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 5)
                section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
            case 2:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(130))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(120))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .paging
            case 3:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3), heightDimension: .absolute(100))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(90))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                
            case 4:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .absolute(80))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(80))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 2)
                
                section = NSCollectionLayoutSection(group: group)
                
            default:
                return nil
            }
            
            return section
        }
        return layout
    }
    
    private func createLayoutForProducts() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            let section: NSCollectionLayoutSection
            
            if sectionIndex == 0 {
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(350))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(350))
                let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
                section = NSCollectionLayoutSection(group: group)
                
            } else {
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .absolute(350))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(350))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
            }
            
            return section
        }
        return layout
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionViewCategories {
            switch section {
            case 0: return 1
            case 1: return viewModel.getCategories().count
            case 2: return viewModel.getBanners().count
            case 3: return viewModel.getServices().count
            case 4: return viewModel.getCoupons().count
            default: return 0
            }
        } else {
            switch section {
            case 0:
                let selectedCategory = viewModel.getCategories()[selectedCategoryIndex]
                return viewModel.getProductsGroupedByCategory(categoryName: selectedCategory.name ?? "").count
            case 1: return viewModel.getGroupedProductsByBrand().count
            case 2: return viewModel.getPromotionalProducts().count
            default: return 0
            }
        }
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if collectionView == collectionViewCategories {
            return 5
        } else {
            return 3
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collectionViewCategories {
            switch indexPath.section {
            case 0:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchBarCell", for: indexPath) as! SearchBarCell
                return cell
            case 1:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as! CategoryCell
                let category = viewModel.categoriesCellForRowAt(indexPath: indexPath)
                cell.configure(with: category, isInitiallySelected: indexPath.row == selectedCategoryIndex)
                cell.delegate = self
                cell.index = indexPath.row
                return cell
            case 2:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BannerCell", for: indexPath) as! BannerCell
                let banner = viewModel.bannerCellForRowAt(indexPath: indexPath)
                cell.configure(with: banner)
                return cell
            case 3:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ServicesCell", for: indexPath) as! ServicesCell
                let service = viewModel.serviceCellForRowAt(indexPath: indexPath)
                cell.configure(with: service)
                return cell
            case 4:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CouponCell", for: indexPath) as! CouponCell
                let coupon = viewModel.couponCellForRowAt(indexPath: indexPath)
                cell.configure(with: coupon)
                return cell
            default:
                return UICollectionViewCell()
            }
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as! ProductCell
            
            switch indexPath.section {
            case 0:
                let selectedCategory = viewModel.getCategories()[selectedCategoryIndex]
                   let productsInCategory = viewModel.getProductsGroupedByCategory(categoryName: selectedCategory.name ?? "")
                   cell.configure(with: productsInCategory[0])
            case 1:
                let productsInBrand = viewModel.getGroupedProductsByBrand()[indexPath.row]
                cell.configure(with: productsInBrand[0])
            case 2:
                let product = viewModel.getPromotionalProducts()[indexPath.row]
                cell.configure(with: product)
            default:
                break
            }
            
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "CategoryHeaderView", for: indexPath) as! CategoryHeaderCell
            switch indexPath.section {
            case 0:
                header.lblHeader.text = "Kategoriye Göre Ürünler"
            case 1:
                header.lblHeader.text = "Markaya Göre Ürünler"
            case 2:
                header.lblHeader.text = "Promosyonlar"
            default:
                break
            }
            return header
        }
        return UICollectionReusableView()
    }

    private func loadProductForSelectedCategory(index: Int, animated: Bool = true) {
        viewModel.setSelectedCategoryIndex(index)
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
            collectionView.reloadData()
        }
        selectedCategoryIndex = index
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == collectionViewCategories && indexPath.section == 1 {
            loadProductForSelectedCategory(index: indexPath.row, animated: true)
            collectionViewCategories.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }

    func didSelectCategory(at index: Int) {
        let indexPath = IndexPath(item: index, section: 1)
        collectionViewCategories.selectItem(at: indexPath, animated: true, scrollPosition: [])
        collectionView(collectionViewCategories, didSelectItemAt: indexPath)
    }
}
