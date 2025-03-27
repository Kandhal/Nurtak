//
//  CircularProgressView.swift
//  Nutrak
//
//  Created by Kandhal AB on 25/03/25.
//


import UIKit

class CircularProgressView: UIView {
    
    private let backgroundCircleLayers: [CAShapeLayer] = [CAShapeLayer(), CAShapeLayer(), CAShapeLayer()]
    private let progressCircleLayers: [CAShapeLayer] = [CAShapeLayer(), CAShapeLayer(), CAShapeLayer()]
    private let progressColors: [UIColor] = [
                                            UIColor(red: 109/255.0, green: 160/255.0, blue: 255/255.0, alpha: 1.0),
                                             UIColor(red: 255/255.0, green: 167/255.0, blue: 38/255.0, alpha: 1.0),
                                             UIColor(red: 102/255.0, green: 187/255.0, blue: 106/255.0, alpha: 1.0)]
    private let backgroundColorAlpha: CGFloat = 0.1 // Transparency of the background circles
    
    private let percentageLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .black
        return label
    }()
    
    var progressValues: [CGFloat] = [1.0, 1.0, 1.0] { // Example values (56%, 75%, 85%)
        didSet {
            updateProgress()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        backgroundColor = .clear
        addSubview(percentageLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        percentageLabel.frame = bounds
        drawCircles()
        updateProgress()
    }
    
    private func drawCircles() {
        let lineWidths: [CGFloat] = [4, 4, 4] // Adjusted thickness for a 110x110 view
        let radiusFactors: [CGFloat] = [0.40, 0.60, 0.80] // Scaled for 110x110 size
        let center = CGPoint(x: bounds.midX, y: bounds.midY)

        for i in 0..<3 {
            let radius = (bounds.width / 2) * radiusFactors[i]

            // Background Circle
            let backgroundPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: -CGFloat.pi / 2, endAngle: 1.5 * CGFloat.pi, clockwise: true)
            backgroundCircleLayers[i].path = backgroundPath.cgPath
            backgroundCircleLayers[i].strokeColor = UIColor.black.withAlphaComponent(backgroundColorAlpha).cgColor
            backgroundCircleLayers[i].fillColor = UIColor.clear.cgColor
            backgroundCircleLayers[i].lineWidth = lineWidths[i]
            backgroundCircleLayers[i].lineCap = .round
            
            if backgroundCircleLayers[i].superlayer == nil {
                layer.addSublayer(backgroundCircleLayers[i])
            }

            // Progress Circle
            progressCircleLayers[i].path = backgroundPath.cgPath
            progressCircleLayers[i].strokeColor = progressColors[i].cgColor
            progressCircleLayers[i].fillColor = UIColor.clear.cgColor
            progressCircleLayers[i].lineWidth = lineWidths[i]
            progressCircleLayers[i].lineCap = .round
            progressCircleLayers[i].strokeEnd = 0
            
            if progressCircleLayers[i].superlayer == nil {
                layer.addSublayer(progressCircleLayers[i])
            }
        }
    }
    private func updateProgress() {
        for i in 0..<progressValues.count {
            let progress = progressValues[i]
            progressCircleLayers[i].strokeEnd = progress
        }
        let percentage = Int(progressValues[0] * 100)
        percentageLabel.text = "\(percentage)%"
    }
}
