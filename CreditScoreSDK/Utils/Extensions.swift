//
//  Extensions.swift
//  CreditScoreDemoApp
//
//  Created by Vishwas Mukund on 17/11/22.
//

import Foundation
import UIKit

extension UIViewController {
    func presentViewController(_ viewController:UIViewController ,style: UIModalPresentationStyle = .fullScreen, animated: Bool = true, completion: (() -> Void)? = nil) {
        viewController.modalPresentationStyle = style
        viewController.modalPresentationCapturesStatusBarAppearance = true
        if self.presentedViewController != nil {
            dismissVC {
                self.present(viewController, animated: animated, completion: completion)
            }
        }
        else {
            present(viewController, animated: animated, completion: completion)
        }
    }
    
    func dismissVC(animated: Bool = true, _ completion: (() -> Void)? = nil) {
        dismiss(animated: true, completion: completion)
    }
}

extension CGFloat {
    var radians: CGFloat {
        return self * Double.pi / 180
    }
    
    var deg2rad: CGFloat {
        return self.radians
    }
    
    var negative: CGFloat {
        return 0 - self
    }
}

extension UIColor {
    
    static let circleChartBackgroundGrey = UIColor(rgb: 0xF4F4F4)
    static let poor = UIColor(rgb: 0xCE4C34)
    static let belowAverage = UIColor(rgb: 0xD25F35)
    static let medium = UIColor(rgb: 0xD98A42)
    static let good = UIColor(rgb: 0xE0BA4C)
    static let excellent = UIColor(rgb: 0xB2CE71)
    
    
   convenience init(red: Int, green: Int, blue: Int) {
       assert(red >= 0 && red <= 255, "Invalid red component")
       assert(green >= 0 && green <= 255, "Invalid green component")
       assert(blue >= 0 && blue <= 255, "Invalid blue component")

       self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
   }

   convenience init(rgb: Int) {
       self.init(
           red: (rgb >> 16) & 0xFF,
           green: (rgb >> 8) & 0xFF,
           blue: rgb & 0xFF
       )
   }
}

extension UITableViewCell {
    class var reuseIdentifier: String {
        String(describing: self)
    }
    
   class func register(tableView: UITableView) {
       tableView.register(self, forCellReuseIdentifier: reuseIdentifier)
    }
}

extension UIView {
    func addSubviews(views: UIView...) {
        for view in views {
            view.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(view)
        }
    }
    
    func setTranslateMaskIntoConstraints() {
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func generateImage() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, 0.0)
        defer { UIGraphicsEndImageContext() }
        if let context = UIGraphicsGetCurrentContext() {
            self.layer.render(in: context)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            return image
        }
        return nil
    }
}

internal class BundleIdentifyingClass { }

extension Bundle {
    static var get: Bundle? {
        let frameWorkBundle = Bundle(for: BundleIdentifyingClass.self)
        
        guard let bundleURL = frameWorkBundle.url(forResource: "ScoreBundle", withExtension: "bundle") else {
           print("Bundle Not found")
            return nil }
        guard let bundle = Bundle(url: bundleURL) else {
            print("Bundle Not Loaded")
            return nil }

        return bundle
    }
}

extension UIImageView {
    func setImageFromBundle(name: String) {
        let bundle = Bundle.get
        self.image = UIImage(named: name, in: bundle, compatibleWith: nil)
    }
}

extension UIImage {
    func setImageFromBundle(name: String) -> UIImage? {
        let bundle = Bundle.get
        return UIImage(named: name, in: bundle, compatibleWith: nil)
    }
}

extension String {
    func width(withHeight constrainedHeight: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: constrainedHeight)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
        return ceil(boundingBox.width)
    }
    
    func height(withWidth constrainedWidth: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: constrainedWidth, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
        return ceil(boundingBox.height)
    }
    
    func getUnderlineAtributedString() -> NSAttributedString {
        let underlineAttribute = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]
        let underlineAttributedString = NSAttributedString(string: self, attributes: underlineAttribute)
        return underlineAttributedString
    }
}


