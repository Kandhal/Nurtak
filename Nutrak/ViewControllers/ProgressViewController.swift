//
//  ProgressViewController.swift
//  Nutrak
//
//  Created by Kandhal AB on 26/03/25.
//


import UIKit

class ProgressViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var percentageLabel: UILabel!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var progress: Float = 0.0
    var timer: Timer?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupProgressView()
        startProgress()
    }
    
    private func setupProgressView() {
        progressView.progress = 0.0
        activityIndicator.transform = CGAffineTransform(scaleX: 5.0, y: 5.0)

    }

    private func startProgress() {
        let duration: TimeInterval = 10.0  // Total duration for progress
        let interval: TimeInterval = 0.1   // Update every 0.1 sec
        let steps = duration / interval
        var currentStep: Float = 0.0

        timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { [weak self] timer in
            guard let self = self else { return }
            currentStep += 1
            self.progress = currentStep / Float(steps)
            self.progressView.setProgress(self.progress, animated: true)
            self.percentageLabel.text = "\(Int(self.progress * 100))%"

            if self.progress >= 1.0 {
                timer.invalidate()
                let nutritionVC = self.storyboard?.instantiateViewController(identifier: "NutritionTableViewController") as! NutritionTableViewController
                self.navigationController?.pushViewController(nutritionVC, animated: true)
            }
        }
    }
}
