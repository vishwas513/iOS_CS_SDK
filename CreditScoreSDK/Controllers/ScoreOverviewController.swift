//
//  ScoreOverviewController.swift
//  CreditScoreDemoApp
//
//  Created by Vishwas Mukund on 17/11/22.
//

import UIKit

protocol ScoreOverviewDelegate {
    func showAnalysis()
    func openARKit(viewImage: UIImage)
}

final class ScoreOverviewController: UIViewController {
    
    private var viewModel: ScoreViewModel!
    private var scoreView: ScoreOverviewView!
    
    var delegate: ScoreOverviewDelegate?
    
    init(scoreViewModel: ScoreViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = scoreViewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError(Constants.fatalErrorText)
    }
    
    override func loadView() {
        scoreView = ScoreOverviewView(viewModel: viewModel)
        scoreView.delegate = self
        view = scoreView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
        scoreView.resetState()
      //  (UIApplication.shared.delegate as! AppDelegate).restrictRotation = .portrait
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadDataIntoView()
    }
    
    private func loadDataIntoView() {
        scoreView.config()
    }
}

extension ScoreOverviewController: ScoreOverviewDelegate {
    func showAnalysis() {
        let controller = ScoreAnalysisController(scoreViewModel: viewModel)
        controller.delegate = self
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func openARKit(viewImage: UIImage) {
        let arController = ARController(viewImage: viewImage)
        navigationController?.pushViewController(arController, animated: true)
    }
}
