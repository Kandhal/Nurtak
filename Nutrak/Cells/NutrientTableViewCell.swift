//
//  NutrientTableViewCell.swift
//  Nutrak
//
//  Created by Kandhal AB on 26/03/25.
//

import UIKit
import Foundation

struct Nutrient {
    let name: String
    let value: String
    let icon: String
}

class NutrientTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var nutriLabel: UILabel!

    var nutrients: [Nutrient] = [] // Data source

    override func awakeFromNib() {
        super.awakeFromNib()
        setupCollectionView()
    }

    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "NutrientCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "NutrientCollectionViewCell")
    }

    func configure(with nutrients: [Nutrient], title: String) {
        self.nutrients = nutrients
        self.titleLabel.text = title
        collectionView.reloadData()
    }
}

// MARK: - UICollectionView Delegate & DataSource
extension NutrientTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return nutrients.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NutrientCollectionViewCell", for: indexPath) as! NutrientCollectionViewCell
        cell.configure(with: nutrients[indexPath.row])
        return cell
    }

    // Adjusts layout based on the section
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        let isMiddleSection = nutrients.count > 1
        return  CGSize(width: 154, height: 54)
    }
}
