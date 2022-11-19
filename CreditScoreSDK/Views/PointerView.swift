//
//  PointerView.swift
//  CreditScoreDemoApp
//
//  Created by Vishwas Mukund on 17/11/22.
//

import UIKit

@IBDesignable
open class PointerView: UIView {

    /// The left-top and left-bottom curvature
    @IBInspectable var cornerRadius: CGFloat      = 15      { didSet { updatePath() } }

    /// The radius for the right tip
    @IBInspectable var rightCornerRadius: CGFloat = 10      { didSet { updatePath() } }

    /// The radius for the top right and bottom right curvature
    @IBInspectable var rightEdgeRadius: CGFloat   = 10      { didSet { updatePath() } }

    /// The fill color
    @IBInspectable var fillColor: UIColor         = .white   { didSet { shapeLayer.fillColor = fillColor.cgColor } }

    /// The stroke color
    @IBInspectable var strokeColor: UIColor       = .clear  { didSet { shapeLayer.strokeColor = strokeColor.cgColor } }

    /// The angle of the tip
    @IBInspectable var angle: CGFloat             = 90      { didSet { updatePath() } }

    /// The line width
    @IBInspectable var lineWidth: CGFloat         = 0       { didSet { updatePath() } }

    /// The shape layer for the pointer
    private lazy var shapeLayer: CAShapeLayer = {
        let _shapeLayer = CAShapeLayer()
        _shapeLayer.fillColor = fillColor.cgColor
        _shapeLayer.strokeColor = strokeColor.cgColor
        _shapeLayer.lineWidth = lineWidth
        return _shapeLayer
    }()

    public override init(frame: CGRect) {
        super.init(frame: frame)

        configure()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        configure()
    }

    private func configure() {
        layer.addSublayer(shapeLayer)
    }

    open override func layoutSubviews() {
        super.layoutSubviews()

        updatePath()
    }

    private func updatePath() {
        let path = UIBezierPath()

        let offset = lineWidth / 2
        let boundingRect = bounds.insetBy(dx: offset, dy: offset)

        let arrowTop = CGPoint(x: boundingRect.maxX - boundingRect.height / 2 / tan(angle * .pi / 180 / 2), y: boundingRect.minY)
        let arrowRight = CGPoint(x: boundingRect.maxX, y: boundingRect.midY)
        let arrowBottom = CGPoint(x: boundingRect.maxX - boundingRect.height / 2 / tan(angle * .pi / 180 / 2), y: boundingRect.maxY)
        let start = CGPoint(x: boundingRect.minX + cornerRadius, y: boundingRect.minY)

        // top left
        path.move(to: start)
        path.addQuadCurve(to: CGPoint(x: boundingRect.minX, y: boundingRect.minY + cornerRadius), controlPoint: CGPoint(x: boundingRect.minX, y: boundingRect.minY))

        // left
        path.addLine(to: CGPoint(x: boundingRect.minX, y: boundingRect.maxY - cornerRadius))

        // lower left
        path.addQuadCurve(to: CGPoint(x: boundingRect.minX + cornerRadius, y: boundingRect.maxY), controlPoint: CGPoint(x: boundingRect.minX, y: boundingRect.maxY))

        // bottom
        path.addLine(to: calculate(from: path.currentPoint, to: arrowBottom, less: rightEdgeRadius))

        // bottom right (before tip)
        path.addQuadCurve(to: calculate(from: arrowRight, to: arrowBottom, less: rightEdgeRadius), controlPoint: arrowBottom)

        // bottom edge of tip
        path.addLine(to: calculate(from: path.currentPoint, to: arrowRight, less: rightCornerRadius))

        // tip
        path.addQuadCurve(to: calculate(from: arrowTop, to: arrowRight, less: rightCornerRadius), controlPoint: arrowRight)

        // top edge of tip
        path.addLine(to: calculate(from: path.currentPoint, to: arrowTop, less: rightEdgeRadius))

        // top right (after tip)
        path.addQuadCurve(to: calculate(from: start, to: arrowTop, less: rightEdgeRadius), controlPoint: arrowTop)

        path.close()

        shapeLayer.lineWidth = lineWidth
        shapeLayer.path = path.cgPath
        
    }

    /// Calculate some point between `startPoint` and `endPoint`, but `distance` from `endPoint
    ///
    /// - Parameters:
    ///   - startPoint: The starting point.
    ///   - endPoint: The ending point.
    ///   - distance: Distance from the ending point
    /// - Returns: Returns the point that is `distance` from the `endPoint` as you travel from `startPoint` to `endPoint`.

    private func calculate(from startPoint: CGPoint, to endPoint: CGPoint, less distance: CGFloat) -> CGPoint {
        let angle = atan2(endPoint.y - startPoint.y, endPoint.x - startPoint.x)
        let totalDistance = hypot(endPoint.y - startPoint.y, endPoint.x - startPoint.x) - distance

        return CGPoint(x: startPoint.x + totalDistance * cos(angle),
                       y: startPoint.y + totalDistance * sin(angle))
    }
}
