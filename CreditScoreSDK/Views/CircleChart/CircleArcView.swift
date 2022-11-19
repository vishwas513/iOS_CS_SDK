//
//  CircleArcView.swift
//  CreditScoreDemoApp
//
//  Created by Vishwas Mukund on 17/11/22.
//

import UIKit

final class CircleArcView: UIView {
    
    var lineWidth: CGFloat = 3              { didSet { setNeedsDisplay(bounds) } }
    var startColor = UIColor.clear          { didSet { setNeedsDisplay(bounds) } }
    var endColor = UIColor.clear            { didSet { setNeedsDisplay(bounds) } }
    var startAngle:CGFloat = 0              { didSet { setNeedsDisplay(bounds) } }
    var endAngle:CGFloat = 360              { didSet { setNeedsDisplay(bounds) } }
    
    private var baseLayer: CAShapeLayer!
    private var baseColor: UIColor!
    
    init(baseColor: UIColor = .black) {
        super.init(frame: .zero)
        self.baseColor = baseColor
        addBaseLayer()
    }
    
    required init?(coder: NSCoder) {
        fatalError(Constants.fatalErrorText)
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        let gradations = Int(endAngle - startAngle)
        
        var startColorR:CGFloat = 0
        var startColorG:CGFloat = 0
        var startColorB:CGFloat = 0
        var startColorA:CGFloat = 0
        
        var endColorR:CGFloat = 0
        var endColorG:CGFloat = 0
        var endColorB:CGFloat = 0
        var endColorA:CGFloat = 0
        
        startColor.getRed(&startColorR, green: &startColorG, blue: &startColorB, alpha: &startColorA)
        endColor.getRed(&endColorR, green: &endColorG, blue: &endColorB, alpha: &endColorA)
        
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        let radius = (min(bounds.width, bounds.height) - lineWidth) / 2
        var angle = startAngle
        
        let totalPath = UIBezierPath()
        
        for i in 0 ... gradations {
            let extraAngle = (endAngle - startAngle) / CGFloat(gradations)
            let currentStartAngle = angle
            let currentEndAngle = currentStartAngle + extraAngle
            
            let currentR = ((endColorR - startColorR) / CGFloat(gradations - 1)) * CGFloat(i - 1) + startColorR
            let currentG = ((endColorG - startColorG) / CGFloat(gradations - 1)) * CGFloat(i - 1) + startColorG
            let currentB = ((endColorB - startColorB) / CGFloat(gradations - 1)) * CGFloat(i - 1) + startColorB
            let currentA = ((endColorA - startColorA) / CGFloat(gradations - 1)) * CGFloat(i - 1) + startColorA
            
            let currentColor = UIColor.init(red: currentR, green: currentG, blue: currentB, alpha: currentA)
            
            let path = UIBezierPath(arcCenter: center, radius: radius, startAngle: currentStartAngle.deg2rad, endAngle: currentEndAngle.deg2rad, clockwise: true)
            
            path.lineWidth = lineWidth
            path.lineCapStyle = .square
            totalPath.append(path)
            currentColor.setStroke()
            path.stroke()
            angle = currentEndAngle
        }
        
        setBaseLayerPath(path: totalPath)
    }
    
    private func setBaseLayerPath(path: UIBezierPath) {
        baseLayer.path = path.cgPath
        baseLayer.lineWidth = lineWidth
    }
    
    private func addBaseLayer() {
        baseLayer = CAShapeLayer()
        baseLayer.lineCap = .square
        baseLayer.strokeColor = baseColor.cgColor
        baseLayer.fillColor = UIColor.clear.cgColor
        layer.mask = baseLayer
    }
    
    func animate() {
        let animation = CABasicAnimation(keyPath: Constants.strokeEndKey)
        animation.timingFunction = CAMediaTimingFunction(name: .easeOut)
        animation.fromValue = 0
        animation.toValue = 1
        animation.duration = 1
        baseLayer.strokeEnd = 1
        baseLayer.add(animation, forKey: Constants.lineKey)
    }
}
