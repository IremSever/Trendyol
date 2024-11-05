//
//  ViewController.swift
//  Trendyol
//
//  Created by IREM SEVER on 5.11.2024.
//

import UIKit

class HomeViewController: UIViewController, UICollectionViewDelegate {
    private var viewModel = HomeViewModel()
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
    }

    func registerCell() {
        collectionView.register(CategoryCell.self, forCellWithReuseIdentifier: "CategoryCell")
        collectionView.register(BannerCell.self, forCellWithReuseIdentifier: "BannerCell")
        collectionView.register(CouponCell.self, forCellWithReuseIdentifier: "CouponCell")
        collectionView.register(ProductCell.self, forCellWithReuseIdentifier: "ProductCell")
        collectionView.register(PopularCell.self, forCellWithReuseIdentifier: "PopularCell")
    }

}

