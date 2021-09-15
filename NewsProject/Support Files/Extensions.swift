//
//  extension.swift
//  NewsProject
//
//  Created by Natallia Askerka on 25.08.21.
//

import Foundation
import UIKit

//MARK:- TableViewCcell
extension UITableView {
    func register<T: UITableViewCell>(cellType: T.Type, bundle: Bundle? = nil) {
        let className = cellType.className
        let nib = UINib(nibName: className, bundle: bundle)
        register(nib, forCellReuseIdentifier: className)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(with type: T.Type, for indexPath: IndexPath) -> T {
        return self.dequeueReusableCell(withIdentifier: type.className, for: indexPath) as! T
    }
}

protocol ClassNameProtocol {
    static var className: String { get }
    var className: String { get }
}

extension ClassNameProtocol {
    public static var className: String {
        return String(describing: self)
    }
    
    public var className: String {
        return type(of: self).className
    }
}

extension NSObject: ClassNameProtocol {}


//MARK:- Animation
private extension UIView {
    func snapshot() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, UIScreen.main.scale)
        drawHierarchy(in: bounds, afterScreenUpdates: true)
        let result = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return result
    }
}


//MARK:- UIWindow

extension UIWindow {
    @objc func replaceRootViewControllerWith(_ replacementController: UIViewController, animated: Bool, completion: (() -> Void)?) {
        let snapshotImageView = UIImageView(image: snapshot())
        
        addSubview(snapshotImageView)
        
        let dismissCompletion = { () -> Void in
            self.rootViewController = replacementController
            self.bringSubviewToFront(snapshotImageView)
            
            if animated {
                UIView.animate(withDuration: 0.3, animations: {
                    snapshotImageView.alpha = 0
                }, completion: { _ in
                    snapshotImageView.removeFromSuperview()
                    completion?()
                })
            } else {
                snapshotImageView.removeFromSuperview()
                completion?()
            }
        }
        
        if rootViewController?.presentedViewController != nil {
            rootViewController?.dismiss(animated: false, completion: dismissCompletion)
        } else {
            dismissCompletion()
        }
    }
}

////MARK:- UIViewController
//extension UIViewController {
//    func createCustomNavigationBar() {
//        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1)
//         
//    }
//}
