//
//  ARController.swift
//  CreditScoreDemoApp
//
//  Created by Vishwas Mukund on 17/11/22.
//

import UIKit
import ARKit
import SceneKit

final class ARController: UIViewController {
    
    private var pinchGesture: UIPinchGestureRecognizer!
    private var tapGesture: UITapGestureRecognizer!

    private var viewImage: UIImage!
    private var modelType: ARModel!
    private var arView: ARView!
    
    private var viewModel = ARViewModel()
    private var inputNode = SCNNode()
    
    init(viewImage: UIImage, modelType: ARModel) {
        super.init(nibName: nil, bundle: nil)
        self.modelType = modelType
        self.viewImage = viewImage
    }
    
    required init?(coder: NSCoder) {
        fatalError(Constants.fatalErrorText)
    }
    
    override func loadView() {
        super.loadView()
        arView = ARView(viewModel: viewModel)
        view = arView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(pinchGestureDetected))
        pinchGesture.delegate = self
        arView.associatePinchGesture(with: pinchGesture)
        
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureDetected))
        tapGesture.delegate = self
        arView.associateTapGesture(with: tapGesture)
        
        arView.showToast()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: false)
        arView.setDelegate(with: self)
        arView.initilizeARScene()
        inputNode = viewModel.make2DNode(image: viewImage, modelType: modelType)
    }
}

extension ARController: ARSCNViewDelegate {
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        inputNode.position = SCNVector3Zero
        inputNode.position.y = SCNVector3Zero.y
        
        arView.stopPlaneDetection()
        return inputNode
    }
}

@objc extension ARController: UIGestureRecognizerDelegate {
    func pinchGestureDetected() {
        if (pinchGesture.state == .changed) {
            let pinchScaleX = Float(pinchGesture.scale) * inputNode.scale.x
            let pinchScaleY =  Float(pinchGesture.scale) * inputNode.scale.y
            let pinchScaleZ =  Float(pinchGesture.scale) * inputNode.scale.z
            inputNode.scale = SCNVector3(pinchScaleX, pinchScaleY, pinchScaleZ)
            pinchGesture.scale = 1
        }
    }
    
    func tapGestureDetected() {
        arView.resetARScene()
    }
}
