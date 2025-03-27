//
//  NutritionTableViewController.swift
//  Nutrak
//
//  Created by Kandhal AB on 26/03/25.
//


import UIKit
import Foundation

struct WeeklyMealData {
    let day: String
    let percentage: CGFloat  // Value between 0 and 1 (normalized)
}

class NutritionTableViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var foodImageView: UIImageView!
    @IBOutlet weak var foodTitleLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!

    let weeklyData: [WeeklyMealData] = [
        WeeklyMealData(day: "S", percentage: 0.4),
        WeeklyMealData(day: "M", percentage: 0.6),
        WeeklyMealData(day: "T", percentage: 0.7),
        WeeklyMealData(day: "W", percentage: 1.0),
        WeeklyMealData(day: "T", percentage: 0.5),
        WeeklyMealData(day: "F", percentage: 0.7),
        WeeklyMealData(day: "S", percentage: 0.6)
    ]

    let sections: [[Nutrient]] = [
        [Nutrient(name: "Calories", value: "320 kcal", icon: "calYellow")], // First section
        [ // Middle section (Macronutrients)
            Nutrient(name: "Proteins", value: "13g", icon: "Proteins"),
            Nutrient(name: "Crabs", value: "35g", icon: "Carbs"),
            Nutrient(name: "Fats", value: "12g", icon: "Fats")
        ],
        [ // Last section (Micronutrients)
            Nutrient(name: "Iron", value: "10%", icon: "VitaminA"),
            Nutrient(name: "Calcium", value: "20%", icon: "Calcium")
        ]
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
        setupCollectionView()
    }
    private func setupUI() {
        // Apply blur gradient to food image
        applyGradientToImageView()

        // Style button
        saveButton.layer.cornerRadius = 10
        saveButton.backgroundColor = UIColor.orange
    }

    private func applyGradientToImageView() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = foodImageView.bounds
        gradientLayer.colors = [
            UIColor.black.withAlphaComponent(0.8).cgColor,  // Dark at top
            UIColor.clear.cgColor,                          // Middle transparent
            UIColor.white.withAlphaComponent(0.8).cgColor   // Light at bottom
        ]
        gradientLayer.locations = [0.0, 0.5, 1.0] // Controls where the colors transition
        foodImageView.layer.sublayers?.forEach { $0.removeFromSuperlayer() } // Remove old layers
        foodImageView.layer.addSublayer(gradientLayer)
    }

    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "NutrientTableViewCell", bundle: nil), forCellReuseIdentifier: "NutrientTableViewCell")
    }
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "MealBarCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MealBarCollectionViewCell")
    }
    @IBAction func actoinBack(sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }
}

// MARK: - UITableView Delegate & DataSource
extension NutritionTableViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1 // Each section has only one row
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NutrientTableViewCell", for: indexPath) as! NutrientTableViewCell
        switch indexPath.section {
        case 0:
            cell.configure(with: sections[indexPath.section], title: "Nutritional Overview:")
        case 1:
            cell.configure(with: sections[indexPath.section], title: "Macronutrients:")
        case 2:
            cell.configure(with: sections[indexPath.section], title: "Micronutrients:")
        default:
            cell.configure(with: sections[indexPath.section], title: "Micronutrients:")
        }
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100 // Adjust height for middle section
    }
}

extension NutritionTableViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weeklyData.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MealBarCollectionViewCell", for: indexPath) as! MealBarCollectionViewCell
        cell.configure(with: weeklyData[indexPath.row])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 12, height: collectionView.frame.height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return (collectionView.frame.size.width - (12*7))/7
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return (collectionView.frame.size.width - (12*7))/7
    }
}
