//
//  RingScoreView.swift
//  CreditScoreDemoApp
//
//  Created by Vishwas Mukund on 17/11/22.
//

import UIKit

final class CircleScoreView: UIView {
    private var headerLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError(Constants.fatalErrorText)
    }
    
    private func setupView() {
        createHeaderLabel()
    }
    
    private func createHeaderLabel() {
        headerLabel = UILabel()
        headerLabel.setTranslateMaskIntoConstraints()
        headerLabel.font = .systemFont(ofSize: 60, weight: .bold)
        addSubview(headerLabel)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            headerLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            headerLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}

extension CircleScoreView {
    func set(title titleText: String, with colour: UIColor) {
        headerLabel.text = titleText
        headerLabel.textColor = colour
    }
}
