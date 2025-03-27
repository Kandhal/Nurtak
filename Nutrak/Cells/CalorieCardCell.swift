//
//  CalorieCardCell.swift
//  Nutrak
//
//  Created by Kandhal AB on 25/03/25.
//

import UIKit

class CalorieCardCell: UITableViewCell {

    @IBOutlet weak var progressView: CircularProgressView!
    @IBOutlet weak var caloriesLabel: UILabel!
    @IBOutlet weak var proteinLabel: UILabel!
    @IBOutlet weak var carbsLabel: UILabel!
    @IBOutlet weak var fatsLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    private func setupUI() {
        progressView.layer.cornerRadius = 5
        progressView.clipsToBounds = true
        contentView.layer.cornerRadius = 12 // Adjust for rounded corners
        contentView.layer.borderWidth = 1   // Border width
        contentView.layer.borderColor = UIColor.lightGray.cgColor // Border color

        // Shadow settings
        contentView.layer.shadowColor = UIColor.black.withAlphaComponent(0.2).cgColor
        contentView.layer.shadowOpacity = 0.5
        contentView.layer.shadowOffset = CGSize(width: 0, height: 4) // Slight bottom shadow
        contentView.layer.shadowRadius = 6
        contentView.layer.masksToBounds = false
    }

    func configure(calories: String, progress: Float, protein: String, carbs: String, fats: String) {
        caloriesLabel.text = "\(calories) kcal"
        proteinLabel.text = "Protein: \(protein)%"
        carbsLabel.text = "Carbs: \(carbs)%"
        fatsLabel.text = "Fats: \(fats)%"
        self.progressView.frame.size = CGSize(width: 180, height: 180)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.progressView.progressValues = [0.45, 0.50, 0.60]
        }
    }
}
