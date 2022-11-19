//
//  ScoreAnalysisController.swift
//  CreditScoreDemoApp
//
//  Created by Vishwas Mukund on 17/11/22.
//

import UIKit

final class ScoreAnalysisController: UIViewController {
    private var viewModel: ScoreViewModel!
    
    private var scoreAnalysisView: ScoreAnalysisView!
    
    var delegate: ScoreOverviewDelegate?
    
    init(scoreViewModel: ScoreViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = scoreViewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError(Constants.fatalErrorText)
    }
    
    override func loadView() {
        scoreAnalysisView = ScoreAnalysisView()
        scoreAnalysisView.setDelegate(with: self)
        scoreAnalysisView.backgroundColor = .white
        view = scoreAnalysisView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupNavBar()
        scoreAnalysisView.resetView()
       // (UIApplication.shared.delegate as! AppDelegate).restrictRotation = .all
    }
    
    func setupNavBar() {
        navigationController?.setNavigationBarHidden(false, animated: false)
        
        let barButtonView = CustomBarButtonView(with: UIImage().setImageFromBundle(name: "ar"))
        barButtonView.delegate = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: barButtonView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

extension ScoreAnalysisController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.scoreData.scoreRanges.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.analysisCellId) as? AnalysisRangeCell else { return UITableViewCell() }
        let data = viewModel.scoreData.scoreRanges[indexPath.row]
        let belongsInRange = viewModel.checkIfScoreInRange(score: viewModel.scoreData.score.value, range: data)
        var payload: Int?
        
        if belongsInRange {
            payload = viewModel.scoreData.score.value
        } else {
            payload = nil
        }
        
        cell.config(scoreRange: data, score: payload)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        Constants.Padding.k60
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        ScoreAnalysisHeaderView(headerText: Constants.whereYouStandText)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        Constants.Padding.k70
    }
}

extension ScoreAnalysisController: CustomBarButtonControl {
    func performAction() {
        scoreAnalysisView.backgroundColor = .clear
        if let viewImage = self.scoreAnalysisView.generateImage() {
            delegate?.openARKit(viewImage: viewImage, modelType: .analysis)
        }
    }
}
