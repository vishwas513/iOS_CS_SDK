//
//  AnalysisRangeCell.swift
//  CreditScoreDemoApp
//
//  Created by Vishwas Mukund on 17/11/22.
//

import UIKit

final class AnalysisRangeCell: UITableViewCell {
    private var scoreRange: ScoreRange!
    
    private var percentageLabel: UILabel!
    private var overlayView: UIView!
    private var rangeLabel: UILabel!
    private var markerView: PointerView!
    private var scoreLabel: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError(Constants.fatalErrorText)
    }
    
    private func setupView() {
        backgroundColor = .clear
        percentageLabel = UILabel()
        percentageLabel.translatesAutoresizingMaskIntoConstraints = false
        percentageLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        percentageLabel.textColor = .black
        
        overlayView = UIView()
        overlayView.translatesAutoresizingMaskIntoConstraints = false
        
        rangeLabel = UILabel()
        rangeLabel.translatesAutoresizingMaskIntoConstraints = false
        rangeLabel.textColor = .white
        
        markerView = PointerView()
        markerView.translatesAutoresizingMaskIntoConstraints = false
        markerView.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        markerView.isHidden = true
        
        scoreLabel = UILabel()
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        scoreLabel.font = .systemFont(ofSize: 18, weight: .bold)
        scoreLabel.isHidden = true
        scoreLabel.textColor = .black
        
        addSubview(percentageLabel)
        addSubview(overlayView)
        addSubview(rangeLabel)
        addSubview(markerView)
        addSubview(scoreLabel)
        
        NSLayoutConstraint.activate([
            percentageLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: Constants.Padding.k8.negative),
            percentageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.Padding.k8),
            
            overlayView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.Padding.k60),
            overlayView.topAnchor.constraint(equalTo: topAnchor),
            overlayView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Constants.Padding.k8.negative),
            overlayView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Constants.Padding.k8.negative),
            
            rangeLabel.leadingAnchor.constraint(equalTo: overlayView.leadingAnchor, constant: Constants.Padding.k16),
            rangeLabel.topAnchor.constraint(equalTo: overlayView.topAnchor, constant: Constants.Padding.k16),
            
            markerView.centerYAnchor.constraint(equalTo: overlayView.centerYAnchor),
            markerView.centerXAnchor.constraint(equalTo: overlayView.centerXAnchor),
            markerView.widthAnchor.constraint(equalToConstant: 100),
            markerView.heightAnchor.constraint(equalToConstant: 50),
            
            scoreLabel.centerXAnchor.constraint(equalTo: markerView.centerXAnchor),
            scoreLabel.centerYAnchor.constraint(equalTo: markerView.centerYAnchor),
            
        ])
    }
}

extension AnalysisRangeCell {
    func config(scoreRange: ScoreRange, score: Int? = nil) {
        self.scoreRange = scoreRange
        percentageLabel.text = "\(scoreRange.percentageOfRange)%"//"\(scoreRange.rangeStart)-\(scoreRange.rangeEnd)%"
        overlayView.backgroundColor = RangeType(rawValue: scoreRange.rangeType)?.getColor()
        rangeLabel.text = "\(scoreRange.rangeStart)-\(scoreRange.rangeEnd)"
        
        if let score = score {
            scoreLabel.text = String(score)
            scoreLabel.isHidden = false
            markerView.isHidden = false
        } else {
            scoreLabel.isHidden = true
            markerView.isHidden = true
        }
    }
}
