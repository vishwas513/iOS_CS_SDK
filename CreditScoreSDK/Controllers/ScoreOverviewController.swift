//
//  ScoreOverviewController.swift
//  CreditScoreDemoApp
//
//  Created by Vishwas Mukund on 17/11/22.
//

import UIKit

protocol ScoreOverviewDelegate: AnyObject {
    func showAnalysis()
    func openARKit(viewImage: UIImage, modelType: ARModel)
}

final class ScoreOverviewController: UIViewController {
    private var viewModel: ScoreViewModel!
    private var scoreView: ScoreOverviewView!
    
    weak var delegate: ScoreOverviewDelegate?
    
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
        setupNavBar()
        loadDataIntoView()
    }
    
    private func loadDataIntoView() {
        scoreView.config()
    }
    
    private func setupNavBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .black

        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
}

extension ScoreOverviewController: ScoreOverviewDelegate {
    func showAnalysis() {
        let controller = ScoreAnalysisController(scoreViewModel: viewModel)
        controller.delegate = self
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func openARKit(viewImage: UIImage, modelType: ARModel) {
        let arController = ARController(viewImage: viewImage, modelType: modelType)
        navigationController?.pushViewController(arController, animated: true)
    }
}
