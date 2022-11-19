//
//  ScoreAnalysisController.swift
//  CreditScoreDemoApp
//
//  Created by Vishwas Mukund on 17/11/22.
//

import UIKit

class ScoreAnalysisController: UIViewController {
    
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
        setupNavBar()
        view = scoreAnalysisView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: false)
        scoreAnalysisView.resetView()
      //  (UIApplication.shared.delegate as! AppDelegate).restrictRotation = .all
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    private func setupNavBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .black

        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
    }
}

extension ScoreAnalysisController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.scoreData.scoreRanges.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? AnalysisRangeCell else { return UITableViewCell() }
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
        60
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        ScoreAnalysisHeaderView(headerText: "Where You Stand")
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 70
    }
}

@objc extension ScoreAnalysisController {
    func addButtonTapped() {
        scoreAnalysisView.backgroundColor = .clear
        if let viewImage = self.scoreAnalysisView.generateImage() {
            delegate?.openARKit(viewImage: viewImage)
        }
       
    }
}
