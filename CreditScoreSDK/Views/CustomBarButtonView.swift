//
//  CustomBarButtonView.swift
//  CreditScoreDemoApp
//
//  Created by Vishwas Mukund on 19/11/22.
//

import UIKit

protocol CustomBarButtonControl: AnyObject {
    func performAction()
}

final class CustomBarButtonView: UIView {
    private var button: UIButton!
    
    private var iconImage: UIImage!
    
    weak var delegate: CustomBarButtonControl?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError(Constants.fatalErrorText)
    }
    
    init(with image: UIImage?) {
        self.init()
        iconImage = image
        setupView()
    }
    
    private func setupView() {
        frame = CGRect(x: .zero, y: .zero, width: Constants.Padding.k30, height: Constants.Padding.k30)
        
        button = UIButton()
        button.setTranslateMaskIntoConstraints()
        let image = iconImage
        let tintedImage = image?.withRenderingMode(.alwaysTemplate)
        
        button.contentMode = .scaleAspectFit
        button.setImage(tintedImage, for: .normal)
        button.imageView?.tintColor = .white
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)

        addSubview(button)
        setupConstraints()
        setTranslateMaskIntoConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            button.leadingAnchor.constraint(equalTo: leadingAnchor),
            button.topAnchor.constraint(equalTo: topAnchor),
            button.bottomAnchor.constraint(equalTo: bottomAnchor),
            button.trailingAnchor.constraint(equalTo: trailingAnchor),
            button.widthAnchor.constraint(equalToConstant: Constants.Padding.k30),
            button.heightAnchor.constraint(equalToConstant: Constants.Padding.k30),
        ])
    }
}

@objc extension CustomBarButtonView {
    func buttonTapped() {
        delegate?.performAction()
    }
}







