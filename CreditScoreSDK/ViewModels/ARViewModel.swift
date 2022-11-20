//
//  File.swift
//  CreditScoreDemoApp
//
//  Created by Vishwas Mukund on 19/11/22.
//

import Foundation
import ARKit

enum ARModel {
    case overview, analysis
    
    func getSize() -> CGSize {
        switch self {
        case .overview:
            return CGSize(width: 1.2, height: 1.4)
        case .analysis:
            return CGSize(width: 1.5, height: 3)
        }
        
    }
}

open class ARViewModel {
    var configuration: ARWorldTrackingConfiguration {
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .vertical
        return configuration
    }
    
    func make2DNode(image: UIImage, modelType: ARModel) -> SCNNode {
        let size = modelType.getSize()
        let plane = SCNPlane(width: size.width, height: size.height)
        plane.firstMaterial!.diffuse.contents = image
        let node = SCNNode(geometry: plane)
        node.constraints = [SCNBillboardConstraint()]
        return node
    }
    
}
