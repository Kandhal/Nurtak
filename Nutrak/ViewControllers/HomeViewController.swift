//
//  ViewController.swift
//  Nutrak
//
//  Created by Kandhal AB on 25/03/25.
//
import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!

    var recommendedRecipes: [Recipe] = [
        Recipe(title: "Mexican Pasta", calories: 320, prepTime: 5, servings: 1, imageName: "pasta_image"),
        Recipe(title: "Chicken Sautee", calories: 250, prepTime: 8, servings: 1, imageName: "chicken_image")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }

    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "UserHeaderCell", bundle: nil), forCellReuseIdentifier: "UserHeaderCell")
        tableView.register(UINib(nibName: "FeatureCardCell", bundle: nil), forCellReuseIdentifier: "FeatureCardCell")
        tableView.register(UINib(nibName: "CalorieCardCell", bundle: nil), forCellReuseIdentifier: "CalorieCardCell")
        tableView.register(UINib(nibName: "RecipeTableViewCell", bundle: nil), forCellReuseIdentifier: "RecipeTableViewCell")
        tableView.register(UINib(nibName: "HealthTipCell", bundle: nil), forCellReuseIdentifier: "HealthTipCell")
        
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 6
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 1 {
            let scanVC = self.storyboard?.instantiateViewController(identifier: "FoodScanningViewController") as! FoodScanningViewController
            self.navigationController?.pushViewController(scanVC, animated: true)
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "UserHeaderCell", for: indexPath) as! UserHeaderCell
            cell.configure(with: "Ahmed", profileImage: UIImage(named: "profile_pic"))
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "FeatureCardCell", for: indexPath) as! FeatureCardCell
            cell.configure(title: "Scan Your Food", description: "Instantly analyze your meal’s nutrition by scanning it.", icon: UIImage(named: "Scan"))
            cell.cardView.backgroundColor = UIColor(red: 218/255.0, green: 239/255.0, blue: 219/255.0, alpha: 1.0)

            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "FeatureCardCell", for: indexPath) as! FeatureCardCell
            cell.configure(title: "Discover Healthy Recipes", description: "Find meals that fit your nutrition goals.", icon: UIImage(named: "recipe_icon"))
            cell.cardView.backgroundColor = UIColor(red: 255/255.0, green: 241/255.0, blue: 220/255.0, alpha: 1.0)

            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CalorieCardCell", for: indexPath) as! CalorieCardCell
            cell.configure(calories: "568.1", progress: 0.56, protein: "45", carbs: "50", fats: "60")
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeTableViewCell", for: indexPath) as! RecipeTableViewCell
            cell.configure(with: recommendedRecipes, sectionTitle: "Recommended For You")
            return cell
        case 5:
            let cell = tableView.dequeueReusableCell(withIdentifier: "HealthTipCell", for: indexPath) as! HealthTipCell
            cell.configure(tip: "Drinking water before meals can help you stay hydrated and eat just the right amount!", tipTitle: "Health Tip of the Day", icon: UIImage(named: "water_glass"))
            return cell
        default:
            return UITableViewCell()
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0: return 50
        case 1: return 80
        case 2: return 80
        case 3: return 190
        case 4: return 252
        case 5: return 104
        default: return UITableView.automaticDimension
        }
    }
    // Add Space Between Sections
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 16 // Adjust this value for more or less spacing
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let spacerView = UIView()
        spacerView.backgroundColor = .clear // Can change to match UI theme
        return spacerView
    }

}
