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
        backgroundColor = .red
        createHeaderLabel()
    }
    
    private func createHeaderLabel() {
        headerLabel = UILabel()//ZLabel(type: .h2, color: ZLabelColor.inverse, alignment: .center)
        headerLabel.font = .systemFont(ofSize: 60, weight: .bold)
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(headerLabel)
        
        NSLayoutConstraint.activate([
            headerLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            headerLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    func set(title titleText: String, with colour: UIColor) {
        headerLabel.text = titleText
        headerLabel.textColor = colour
        backgroundColor = .red
    }
}
