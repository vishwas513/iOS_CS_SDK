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
    
    private var sceneView: ARSCNView!
    private var pinchGesture: UIPinchGestureRecognizer!
    private var tapGesture: UITapGestureRecognizer!
    
    private var viewImage: UIImage!
    private var inputNode = SCNNode()
    
    init(viewImage: UIImage) {
        super.init(nibName: nil, bundle: nil)
        self.viewImage = viewImage
    }
    
    required init?(coder: NSCoder) {
        fatalError(Constants.fatalErrorText)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        sceneView = ARSCNView()
        sceneView.translatesAutoresizingMaskIntoConstraints = false
        
        pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(pinchGestureDetected))
        pinchGesture.delegate = self
        sceneView.addGestureRecognizer(pinchGesture)
        
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureDetected))
        tapGesture.delegate = self
        sceneView.addGestureRecognizer(tapGesture)
        
        view.addSubview(sceneView)
        
        NSLayoutConstraint.activate([
            sceneView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            sceneView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            sceneView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            sceneView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        sceneView.session.pause()
//            sceneView.scene.rootNode.enumerateChildNodes { (node, stop) in
//                node.removeFromParentNode()
//            }
//
//            let configuration = ARWorldTrackingConfiguration()
//            configuration.planeDetection = .vertical
//            sceneView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
//    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: false)
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .vertical
        
        sceneView.session.run(configuration)
        sceneView.delegate = self
        
        inputNode = make2DNode(image: viewImage)
    }
}

extension ARController: ARSCNViewDelegate {
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        inputNode.position = SCNVector3Zero
        inputNode.position.y = SCNVector3Zero.y
        
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = []
        self.sceneView.session.run(configuration)
        
        return inputNode
    }
    
    func make2DNode(image: UIImage, width: CGFloat = 1.7, height: CGFloat = 2) -> SCNNode {
        let plane = SCNPlane(width: width, height: height)
        plane.firstMaterial!.diffuse.contents = image
        let node = SCNNode(geometry: plane)
        node.constraints = [SCNBillboardConstraint()]
        return node
    }
}

@objc extension ARController {
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
        sceneView.session.pause()
        sceneView.scene.rootNode.enumerateChildNodes { (node, stop) in
            node.removeFromParentNode()
        }
        
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .vertical
        sceneView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
    }
}

extension ARController: UIGestureRecognizerDelegate {
    
}
