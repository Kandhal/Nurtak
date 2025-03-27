//
//  HealthTipCell.swift
//  Nutrak
//
//  Created by Kandhal AB on 26/03/25.
//

import UIKit

class HealthTipCell: UITableViewCell {

    @IBOutlet weak var tipCardView: UIView!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var tipTitleLabel: UILabel!
    @IBOutlet weak var tipIconImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    private func setupUI() {
        tipCardView.layer.cornerRadius = 10
        tipCardView.layer.shadowColor = UIColor.black.cgColor
        tipCardView.layer.shadowOpacity = 0.1
        tipCardView.layer.shadowOffset = CGSize(width: 0, height: 2)
        tipCardView.layer.shadowRadius = 4
    }

    func configure(tip: String, tipTitle: String, icon: UIImage?) {
        tipLabel.text = tip
        tipIconImageView.image = icon
        tipTitleLabel.text = tipTitle
    }
}
