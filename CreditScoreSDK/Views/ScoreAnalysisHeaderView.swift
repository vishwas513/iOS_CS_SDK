//
//  ScoreAnalysisHeaderView.swift
//  CreditScoreDemoApp
//
//  Created by Vishwas Mukund on 17/11/22.
//

import UIKit

final class ScoreAnalysisHeaderView: UIView {
    private var iconImageView: UIImageView!
    private var headerLabel: UILabel!
    private var iButton: UIButton!
    
    private var headerText = String()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError(Constants.fatalErrorText)
    }
    
    init(headerText: String) {
        self.init()
        self.headerText = headerText
        setupView()
    }
    
    private func setupView() {
        backgroundColor = .clear
        
        iconImageView = UIImageView()
        iconImageView.setImageFromBundle(name: "radar")
        
        headerLabel = UILabel()
        headerLabel.text = headerText
        headerLabel.textColor = .black
        headerLabel.font = .systemFont(ofSize: 24, weight: .medium)
        
        addSubviews(views: iconImageView, headerLabel)
        
        NSLayoutConstraint.activate([
            iconImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.Padding.k50),
            iconImageView.topAnchor.constraint(equalTo: topAnchor, constant: Constants.Padding.k16),
            iconImageView.widthAnchor.constraint(equalToConstant: Constants.Padding.k24),
            iconImageView.heightAnchor.constraint(equalToConstant: Constants.Padding.k24),
            
            headerLabel.centerYAnchor.constraint(equalTo: iconImageView.centerYAnchor),
            headerLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: Constants.Padding.k16),
        ])
    }
}
