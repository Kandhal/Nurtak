//
//  RecipeTableViewCell.swift
//  Nutrak
//
//  Created by Kandhal AB on 26/03/25.
//

import UIKit

class RecipeTableViewCell: UITableViewCell {
    
    static let identifier = "RecipeTableViewCell"
    
    @IBOutlet weak var sectionTitleLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var viewAllButton: UIButton!

    var recipes: [Recipe] = []

    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let nib = UINib(nibName: "RecipeCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "RecipeCollectionViewCell")
    }
    
    func configure(with recipes: [Recipe], sectionTitle: String) {
        self.recipes = recipes
        sectionTitleLabel.text = sectionTitle
        collectionView.reloadData()
    }
}

// MARK: - UICollectionView Delegate & DataSource
extension RecipeTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recipes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecipeCollectionViewCell", for: indexPath) as! RecipeCollectionViewCell
        cell.configure(with: recipes[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 180, height: 210) // Adjust cell width & height
    }
}
