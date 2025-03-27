//
//  RecipeCollectionViewCell.swift
//  Nutrak
//
//  Created by Kandhal AB on 26/03/25.
//
import UIKit

struct Recipe {
    let title: String
    let calories: Int
    let prepTime: Int
    let servings: Int
    let imageName: String
}

class RecipeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var dishImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var caloriesLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var prepTimeLabel: UILabel!
    @IBOutlet weak var servingsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Cell Styling
        contentView.layer.cornerRadius = 12
        contentView.layer.masksToBounds = false
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOpacity = 0.1
        contentView.layer.shadowOffset = CGSize(width: 0, height: 2)
        contentView.layer.shadowRadius = 4
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.lightGray.cgColor
        
        dishImageView.layer.cornerRadius = 10
        dishImageView.clipsToBounds = true
    }
    
    func configure(with recipe: Recipe) {
        titleLabel.text = recipe.title
        caloriesLabel.text = "\(recipe.calories) kcal per serving"
        ratingLabel.text = "⭐️⭐️⭐️⭐️⭐️"  // Assuming static rating for now
        prepTimeLabel.text = "\(recipe.prepTime) min prep"
        servingsLabel.text = "\(recipe.servings) serving"
        dishImageView.image = UIImage(named: recipe.imageName) // Use local images
    }
}
