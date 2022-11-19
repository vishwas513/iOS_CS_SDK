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
    private var scoreAnalysisButton: UIButton!
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
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = .clear
        
        circleProgressBar = CircleProgressBar()
        circleProgressBar.translatesAutoresizingMaskIntoConstraints = false
        circleProgressBar.backgroundColor = .clear
        
        rangeStartLabel = UILabel()
        rangeStartLabel.translatesAutoresizingMaskIntoConstraints = false
        rangeStartLabel.font = .systemFont(ofSize: 14, weight: .semibold)
        rangeStartLabel.textColor = .black
        
        
        rangeEndLabel = UILabel()
        rangeEndLabel.translatesAutoresizingMaskIntoConstraints = false
        rangeEndLabel.font = .systemFont(ofSize: 14, weight: .semibold)
        rangeEndLabel.textColor = .black
       
        
        lastCheckedOnLabel = UILabel()
        lastCheckedOnLabel.translatesAutoresizingMaskIntoConstraints = false
        lastCheckedOnLabel.font = .systemFont(ofSize: 14, weight: .semibold)
        lastCheckedOnLabel.textColor = .black
        
        scoreAnalysisButton = UIButton()
        scoreAnalysisButton.translatesAutoresizingMaskIntoConstraints = false
        scoreAnalysisButton.setTitle("hi", for: .normal)
        
        arKitButton = UIButton()
        arKitButton.translatesAutoresizingMaskIntoConstraints = false
        arKitButton.setTitle("ARKit view", for: .normal)
        arKitButton.setTitleColor(.green, for: .normal)
        arKitButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        let underlineAttribute = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.thick.rawValue]
        let underlineAttributedString = NSAttributedString(string: "🔍   See my Score Analysis", attributes: underlineAttribute)
        scoreAnalysisButton.setAttributedTitle(underlineAttributedString, for: .normal)
        scoreAnalysisButton.addTarget(self, action: #selector(scoreAnalysisButtonTapped), for: .touchUpInside)
        scoreAnalysisButton.setTitleColor(.blue, for: .normal)
        
        addSubview(containerView)
        containerView.addSubview(circleProgressBar)
        containerView.addSubview(rangeStartLabel)
        containerView.addSubview(rangeEndLabel)
        containerView.addSubview(lastCheckedOnLabel)
        addSubview(scoreAnalysisButton)
        addSubview(arKitButton)
        
        NSLayoutConstraint.activate([
            
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.Padding.k60),
            containerView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Constants.Padding.k60.negative),
            
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
            
            scoreAnalysisButton.centerXAnchor.constraint(equalTo: circleProgressBar.centerXAnchor),
            scoreAnalysisButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Constants.Padding.k60.negative),
            
            arKitButton.bottomAnchor.constraint(equalTo: scoreAnalysisButton.topAnchor, constant: -60),
            arKitButton.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
    }
}

extension ScoreOverviewView {
    func config() {
        guard let rangeType = RangeType(rawValue: viewModel.scoreData.score.rangeType) else { return }
        
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

@objc extension ScoreOverviewView {
    func scoreAnalysisButtonTapped() {
        delegate?.showAnalysis()
    }
    
    func buttonTapped() {
        rangeStartLabel.textColor = .white
        rangeEndLabel.textColor = .white
        lastCheckedOnLabel.textColor = .white
        if let viewImage = containerView.generateImage() {
            delegate?.openARKit(viewImage: viewImage)
        }
        
    }
}

