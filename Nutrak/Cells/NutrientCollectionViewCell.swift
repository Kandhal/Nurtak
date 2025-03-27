//
//  NutrientCollectionViewCell.swift
//  Nutrak
//
//  Created by Kandhal AB on 26/03/25.
//

import UIKit

class NutrientCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.layer.cornerRadius = 12
        contentView.layer.masksToBounds = false
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOpacity = 0.1
        contentView.layer.shadowOffset = CGSize(width: 0, height: 2)
        contentView.layer.shadowRadius = 4
        contentView.layer.borderWidth = 0.5
        contentView.layer.borderColor = UIColor.lightGray.cgColor
    }
    func configure(with nutrient: Nutrient) {
        iconImageView.image = UIImage(named: nutrient.icon)
        titleLabel.text = nutrient.name
        valueLabel.text = nutrient.value
    }
}
