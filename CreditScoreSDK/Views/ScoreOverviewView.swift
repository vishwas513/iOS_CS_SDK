//
//  ScoreOverviewView.swift
//  CreditScoreDemoApp
//
//  Created by Vishwas Mukund on 17/11/22.
//

import UIKit

final class ScoreOverviewView: UIView {
    private var viewModel: ScoreViewModel!
    
    private var containerView: UIView!
    private var circleProgressBar: CircleProgressBar!
    private var rangeStartLabel: UILabel!
    private var rangeEndLabel: UILabel!
    private var lastCheckedOnLabel: UILabel!
    private var lensLabel: UILabel!
    private var scoreAnalysisButton: UIButton!
    private var arLabel: UIButton!
    private var arKitButton: UIButton!
    
    var delegate: ScoreOverviewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError(Constants.fatalErrorText)
    }
    
    init(viewModel: ScoreViewModel) {
        self.init()
        self.viewModel = viewModel
        
        setupView()
    }
    
    private func setupView() {
        backgroundColor = .white
        
        containerView = UIView()
        containerView.backgroundColor = .clear
        
        circleProgressBar = CircleProgressBar()
        
        rangeStartLabel = UILabel()
        rangeStartLabel.font = .systemFont(ofSize: 14, weight: .semibold)
        rangeStartLabel.textColor = .black
        
        rangeEndLabel = UILabel()
        rangeEndLabel.font = .systemFont(ofSize: 14, weight: .semibold)
        rangeEndLabel.textColor = .black
       
        lastCheckedOnLabel = UILabel()
        lastCheckedOnLabel.font = .systemFont(ofSize: 14, weight: .semibold)
        lastCheckedOnLabel.textColor = .black
        
        lensLabel = UILabel()
        lensLabel.text = Constants.lensUnicodeCharacter
        
        scoreAnalysisButton = UIButton()
        scoreAnalysisButton.setAttributedTitle(Constants.seeMyScoreAnalysisText.getUnderlineAtributedString(), for: .normal)
        scoreAnalysisButton.addTarget(self, action: #selector(scoreAnalysisButtonTapped), for: .touchUpInside)
        scoreAnalysisButton.setTitleColor(.blue, for: .normal)
        
        arLabel = UIButton()
        arLabel.addTarget(self, action: #selector(arButtonTapped), for: .touchUpInside)
        arLabel.setTitle(Constants.showARButtonText, for: .normal)
        arLabel.setTitleColor(.blue, for: .normal)
        
        arKitButton = UIButton()
        arKitButton.setImage(UIImage().setImageFromBundle(name: "ar"), for: .normal)
        arKitButton.setTitleColor(.green, for: .normal)
        arKitButton.addTarget(self, action: #selector(arButtonTapped), for: .touchUpInside)
        arKitButton.setTitleColor(.blue, for: .normal)
        
        containerView.addSubviews(views: circleProgressBar, rangeStartLabel, rangeEndLabel, lastCheckedOnLabel)
        addSubviews(views: containerView, lensLabel, scoreAnalysisButton, arLabel, arKitButton)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: Constants.Padding.k30),
            containerView.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            circleProgressBar.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            circleProgressBar.topAnchor.constraint(equalTo: containerView.topAnchor),
            circleProgressBar.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            
            rangeStartLabel.centerXAnchor.constraint(equalTo: circleProgressBar.centerXAnchor, constant: Constants.Padding.k30),
            rangeStartLabel.bottomAnchor.constraint(equalTo: circleProgressBar.bottomAnchor),
            
            rangeEndLabel.centerYAnchor.constraint(equalTo: circleProgressBar.centerYAnchor, constant: Constants.Padding.k30),
            rangeEndLabel.trailingAnchor.constraint(equalTo: circleProgressBar.trailingAnchor),
            
            lastCheckedOnLabel.centerXAnchor.constraint(equalTo: circleProgressBar.centerXAnchor),
            lastCheckedOnLabel.topAnchor.constraint(equalTo: circleProgressBar.bottomAnchor, constant: Constants.Padding.k30),
            lastCheckedOnLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: Constants.Padding.k8.negative),
            
            lensLabel.trailingAnchor.constraint(equalTo: scoreAnalysisButton.leadingAnchor, constant: Constants.Padding.k8.negative),
            lensLabel.centerYAnchor.constraint(equalTo: scoreAnalysisButton.centerYAnchor),
            
            scoreAnalysisButton.centerXAnchor.constraint(equalTo: circleProgressBar.centerXAnchor),
            scoreAnalysisButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Constants.Padding.k60.negative),
            
            arLabel.centerXAnchor.constraint(equalTo: centerXAnchor, constant: Constants.Padding.k16.negative),
            arLabel.centerYAnchor.constraint(equalTo: arKitButton.centerYAnchor),
            
            arKitButton.bottomAnchor.constraint(equalTo: scoreAnalysisButton.topAnchor, constant: -60),
            arKitButton.leadingAnchor.constraint(equalTo: arLabel.trailingAnchor, constant: Constants.Padding.k4),
            arKitButton.widthAnchor.constraint(equalToConstant: Constants.Padding.k40),
            arKitButton.heightAnchor.constraint(equalToConstant: Constants.Padding.k40),
        ])
    }
}

extension ScoreOverviewView {
    func config() {
        guard let rangeType = viewModel.getRangeWith(score: viewModel.scoreData.score.value) else { return }
        
        circleProgressBar.config(progressArcStartColor: rangeType.getColor(), endColor: rangeType.getColor(), backgroundArcColor: .circleChartBackgroundGrey)
        circleProgressBar.set(progress: viewModel.getPercentage())
        circleProgressBar.set(score: String(viewModel.scoreData.score.value), with: rangeType.getColor())
        circleProgressBar.animateProgress()
        rangeStartLabel.text = String(viewModel.scoreData.scoreOverview.rangeStart)
        rangeEndLabel.text = String(viewModel.scoreData.scoreOverview.rangeEnd)
        lastCheckedOnLabel.text = viewModel.getFormattedDateString()
    }
    
    func resetState() {
        rangeStartLabel.textColor = .black
        rangeEndLabel.textColor = .black
        lastCheckedOnLabel.textColor = .black
    }
}

@objc private extension ScoreOverviewView {
    func scoreAnalysisButtonTapped() {
        delegate?.showAnalysis()
    }
    
    func arButtonTapped() {
        rangeStartLabel.textColor = .white
        rangeEndLabel.textColor = .white
        lastCheckedOnLabel.textColor = .white
        if let viewImage = containerView.generateImage() {
            delegate?.openARKit(viewImage: viewImage, modelType: .overview)
        }
    }
}
