//
//  UIView+Extensions.swift
//  Sakura
//
//  Created by Corey Roberts on 4/1/20.
//

import Foundation
import CoreGraphics


extension UIView {

    func maskView(with window: UIWindow, visibleSize: CGSize) {

        // If there's no root view, we have nothing to do!
        guard let rootViewController = window.rootViewController else {
            return
        }

        // If this view controller is a navigation controller, let's mask the navigation bar
        if let rootViewController = rootViewController as? UINavigationController {
            let rect: CGRect = CGRect(x: rootViewController.view.bounds.origin.x,
                                      y: rootViewController.topbarHeight,
                                      width: visibleSize.width,
                                      height: visibleSize.height)
            let path: UIBezierPath = UIBezierPath(rect: rect)
            let maskLayer: CAShapeLayer = CAShapeLayer()
            maskLayer.path = path.cgPath
            layer.mask = maskLayer
        }

    }


}


extension UIViewController {

    var statusBarHeight: CGFloat {

        if #available(iOS 13.0, *) {
            return view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0.0
        } else {
            return UIApplication.shared.statusBarFrame.size.height
        }

    }

    var topbarHeight: CGFloat {
        if #available(iOS 13.0, *) {

            let navigationBarHeight: CGFloat

            if let navigationController = self as? UINavigationController {
                navigationBarHeight = navigationController.navigationBar.frame.height
            }
            else {
                navigationBarHeight = navigationController?.navigationBar.frame.height ?? 0.0
            }

            return (view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0.0) + navigationBarHeight
        }
        else {

            let navigationBarHeight: CGFloat

            if let navigationController = self as? UINavigationController {
                navigationBarHeight = navigationController.navigationBar.frame.height
            }
            else {
                navigationBarHeight = navigationController?.navigationBar.frame.height ?? 0.0
            }

            return UIApplication.shared.statusBarFrame.size.height + navigationBarHeight
        }
    }
}
