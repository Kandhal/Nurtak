//
//  MealBarCollectionViewCell.swift
//  Nutrak
//
//  Created by Kandhal AB on 26/03/25.
//

import UIKit

class MealBarCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var barView: UIView!
    @IBOutlet weak var dayLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    private func setupUI() {
        barView.layer.cornerRadius = 5
        barView.clipsToBounds = true
        barView.backgroundColor = UIColor.clear
    }

    func configure(with data: WeeklyMealData) {
        dayLabel.text = data.day

        // Create gradient effect
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.green.cgColor, UIColor.orange.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 1)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.frame = CGRect(x: 0, y: barView.frame.height * (1 - data.percentage), width: barView.frame.width, height: barView.frame.height * data.percentage)

        barView.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
        barView.layer.addSublayer(gradientLayer)
    }
}
