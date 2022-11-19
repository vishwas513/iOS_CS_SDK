//
//  ARView.swift
//  CreditScoreDemoApp
//
//  Created by Vishwas Mukund on 19/11/22.
//

import UIKit
import ARKit

final class ARView: UIView {
    private var sceneView: ARSCNView!
    private var toastMessage: UILabel!
    
    private var viewModel: ARViewModel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError(Constants.fatalErrorText)
    }
    
    init(viewModel: ARViewModel) {
        self.init()
        self.viewModel = viewModel
        setupView()
    }
    
    private func setupView() {
        sceneView = ARSCNView()
        
        toastMessage = UILabel()
        toastMessage.setTranslateMaskIntoConstraints()
        toastMessage.backgroundColor = .white
        toastMessage.text = Constants.toastMessageText
        toastMessage.layer.borderWidth = 0.3
        toastMessage.font = .systemFont(ofSize: 14, weight: .light)
        toastMessage.layer.borderColor = UIColor.black.cgColor
        toastMessage.layer.cornerRadius = 10
        toastMessage.textAlignment = .center
        toastMessage.textColor = .black
        toastMessage.clipsToBounds = true
        
        addSubviews(views: sceneView)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            sceneView.leadingAnchor.constraint(equalTo: leadingAnchor),
            sceneView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            sceneView.trailingAnchor.constraint(equalTo: trailingAnchor),
            sceneView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}

extension ARView {
    func associateTapGesture(with gesture: UITapGestureRecognizer) {
        sceneView.addGestureRecognizer(gesture)
    }
    
    func associatePinchGesture(with gesture: UIPinchGestureRecognizer) {
        sceneView.addGestureRecognizer(gesture)
    }
    
    func setDelegate(with controller: UIViewController) {
        sceneView.delegate = controller as? any ARSCNViewDelegate
    }
    
    func resetARScene() {
        sceneView.session.pause()
        sceneView.scene.rootNode.enumerateChildNodes { (node, stop) in
            node.removeFromParentNode()
        }
    
        sceneView.session.run(viewModel.configuration, options: [.resetTracking, .removeExistingAnchors])
    }
    
    func initilizeARScene() {
        sceneView.session.run(viewModel.configuration)
    }
    
    func stopPlaneDetection() {
        let configuration = viewModel.configuration
        configuration.planeDetection = []
        self.sceneView.session.run(configuration)
    }
    
    func showToast() {
        addSubview(toastMessage)
        
        NSLayoutConstraint.activate([
            toastMessage.centerXAnchor.constraint(equalTo: centerXAnchor),
            toastMessage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Constants.Padding.k60.negative),
            toastMessage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.Padding.k8),
            toastMessage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Constants.Padding.k8.negative),
        ])
        
        UIView.animate(withDuration: 6.0, delay: 0.1, options: .curveEaseOut, animations: {
            self.toastMessage.alpha = 0.0
        }, completion: {(isCompleted) in
            self.toastMessage.removeFromSuperview()
        })
    }
    
    
}
