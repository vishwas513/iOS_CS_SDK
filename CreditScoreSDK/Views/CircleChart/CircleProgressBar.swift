//
//  File.swift
//  CreditScoreDemoApp
//
//  Created by Vishwas Mukund on 17/11/22.
//

import UIKit

final class CircleProgressBar: UIView {
    private var scoreView: CircleScoreView!
    private var completeArcLayer: CAShapeLayer!
    private var progressGradientArc: CircleArcView!

    private var radius: CGFloat = 90
    private let arcStrokeWidth: CGFloat = 18
    private let arcStartAngle: CGFloat = 90
    private let arcEndAngle: CGFloat = 0
    private let completeArcColor: UIColor = .lightGray
    
    private var progressValue: Int = .zero
    
    private var arcPath: UIBezierPath {
        let overallArcPath = UIBezierPath(arcCenter: CGPoint(x: bounds.midX, y: bounds.midY), radius: radius - arcStrokeWidth/2, startAngle: arcStartAngle.deg2rad, endAngle: arcEndAngle.deg2rad, clockwise: true)
        return overallArcPath
    }
    
    init(radius: CGFloat = 137) {
        super.init(frame: .zero)
        self.radius = radius
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError(Constants.fatalErrorText)
    }
    
    private func setupView() {
        createCompleteArc()
        createProgressArc()
        createScoreView()
        
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: 2*radius),
            heightAnchor.constraint(equalToConstant: 2*radius)
        ])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        drawCompleteArcLayer()
    }
    
    private func drawCompleteArcLayer()  {
        completeArcLayer.path = arcPath.cgPath
    }
    
    private func createCompleteArc() {
        completeArcLayer = CAShapeLayer()
        completeArcLayer.strokeColor = completeArcColor.cgColor
        completeArcLayer.lineWidth = arcStrokeWidth
        completeArcLayer.fillColor = UIColor.clear.cgColor
        completeArcLayer.lineCap = .square
        layer.addSublayer(completeArcLayer)
    }
    
    private func createProgressArc() {
        progressGradientArc = CircleArcView()
        progressGradientArc.translatesAutoresizingMaskIntoConstraints = false
        addSubview(progressGradientArc)
        
        NSLayoutConstraint.activate([
            progressGradientArc.leadingAnchor.constraint(equalTo: leadingAnchor),
            progressGradientArc.trailingAnchor.constraint(equalTo: trailingAnchor),
            progressGradientArc.topAnchor.constraint(equalTo: topAnchor),
            progressGradientArc.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        progressGradientArc.backgroundColor = .clear
        progressGradientArc.startAngle = arcStartAngle
        progressGradientArc.lineWidth = arcStrokeWidth
    }
    
    private func createScoreView() {
        scoreView = CircleScoreView()
        scoreView.backgroundColor = .red
        scoreView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(scoreView)
        
        NSLayoutConstraint.activate([
            scoreView.centerXAnchor.constraint(equalTo: progressGradientArc.centerXAnchor),
            scoreView.centerYAnchor.constraint(equalTo: progressGradientArc.centerYAnchor)
        ])
    }
    
    private func endAngle(forProgress progress: Int) -> CGFloat {
        let angleDiff = 360 - (arcStartAngle - arcEndAngle)
        let singleProgress = angleDiff/100
        return  arcStartAngle + CGFloat(progress)*singleProgress
    }
}

extension CircleProgressBar {
    
    func config(progressArcStartColor startColor: UIColor = .gray, endColor: UIColor = .gray, backgroundArcColor: UIColor = .gray, arcStrokeWidth: CGFloat = 18) {
        completeArcLayer.strokeColor = backgroundArcColor.cgColor
        completeArcLayer.lineWidth = arcStrokeWidth
        progressGradientArc.startColor = startColor
        progressGradientArc.endColor = endColor
    }
    
    //value between 0 and 100
    func set(progress progressValue: Int) {
        progressGradientArc.endAngle = endAngle(forProgress: Int(progressValue))
    }
    
    func set(score scoreValue: String, with color: UIColor) {
        scoreView.set(title: scoreValue, with: color)
    }
    
    func animateProgress() {
        progressGradientArc.animate()
    }
}
