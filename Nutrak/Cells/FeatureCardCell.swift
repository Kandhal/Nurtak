//
//  FeatureCardCell.swift
//  Nutrak
//
//  Created by Kandhal AB on 25/03/25.
//

import UIKit

import UIKit

class FeatureCardCell: UITableViewCell {

    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    private func setupUI() {
        cardView.layer.cornerRadius = 10
        cardView.layer.shadowColor = UIColor.black.cgColor
        cardView.layer.shadowOpacity = 0.1
        cardView.layer.shadowOffset = CGSize(width: 0, height: 2)
        cardView.layer.shadowRadius = 4
    }

    func configure(title: String, description: String, icon: UIImage?) {
        titleLabel.text = title
        descriptionLabel.text = description
        iconImageView.image = icon
    }
}
