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
    }

    private func setupCollectionViews() {
        collectionViewCategories.delegate = self
        collectionViewCategories.dataSource = self
        collectionView.delegate = self
        collectionView.dataSource = self
        registerCells()
    }

    func registerCells() {
        collectionViewCategories.register(UINib(nibName: "CategoryCell", bundle: nil), forCellWithReuseIdentifier: "CategoryCell")
        collectionView.register(UINib(nibName: "ProductCell", bundle: nil), forCellWithReuseIdentifier: "ProductCell")
        collectionView.register(UINib(nibName: "BannerCell", bundle: nil), forCellWithReuseIdentifier: "BannerCell")
        collectionView.register(UINib(nibName: "CouponCell", bundle: nil), forCellWithReuseIdentifier: "CouponCell")
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

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionViewCategories {
            return viewModel.categoriesNumberOfRowsInSection(section: section)
        } else {
            return viewModel.getSelectedCategoryProducts().count
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
            let product = viewModel.templateCellForRowAt(indexPath: indexPath)
            cell.configure(with: product)
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == collectionViewCategories {
            loadContentForSelectedCategory(index: indexPath.row, animated: true)
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
