//
//  Sakura.swift
//  Sakura
//
//  Created by Corey Roberts on 4/17/19.
//

import Foundation
import UIKit


public enum PetalStyle {
    
    case standard
    case loading
    case success
    case failure
    case custom(color: UIColor, accessoryView: UIView?)
    
    var color: UIColor {
        switch self {
        case .standard:             return #colorLiteral(red: 1, green: 0.7176470588, blue: 0.7725490196, alpha: 1)
        case .loading:              return #colorLiteral(red: 1, green: 0.7176470588, blue: 0.7725490196, alpha: 1)
        case .success:              return #colorLiteral(red: 0.5529411765, green: 0.8509803922, blue: 0.4823529412, alpha: 1)
        case .failure:              return #colorLiteral(red: 1, green: 0.4509803922, blue: 0.4509803922, alpha: 1)
        case .custom(let color, _): return color
        }
    }
    
    var accessoryView: UIView? {
        switch self {
        case .standard: return nil
        case .loading: return UIActivityIndicatorView(activityIndicatorStyle: .white)
        case .success: return nil
        case .failure: return nil
        case .custom(_, let accessoryView): return accessoryView
        }
    }
    
}

public struct Message {
    
    let message: String
    
    public init(message: String) {
        self.message = message
    }
    
}

public final class Petal {
    
    weak var destinationView: UIView?
    let message: Message
    let style: PetalStyle
    
    public init(navigationController: UINavigationController, message: Message, style: PetalStyle) {
        self.destinationView = navigationController.view
        self.message = message
        self.style = style
    }
    
    public init(viewController: UIView, message: Message, style: PetalStyle) {
        self.destinationView = viewController
        self.message = message
        self.style = style
    }
    
}

public final class Sakura {
    
    public static let shared: Sakura = Sakura()
    private var queue: [Petal] = [Petal]()
    weak var currentPetal: Petal?
    
    public init() { }
    
    public func display(petal: Petal) {
        queue.append(petal)
        currentPetal = petal
        animate(petal: petal)
    }
    
    private func animate(petal: Petal) {
        let sakuraView: SakuraView = SakuraView(petal: petal)
        sakuraView.backgroundColor = .purple
        
        guard let view = petal.destinationView else { return }
        
        view.addSubview(sakuraView)
        
        sakuraView.topAnchor.constraint(equalTo: view.topAnchor, constant: 80.0).isActive = true
        sakuraView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        sakuraView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        sakuraView.heightAnchor.constraint(equalToConstant: 44.0).isActive = true
        
        // TODO: Animation
        
    }
    
    public func dismiss() {

        guard let petal = currentPetal, let view = petal.destinationView else { return }
        
        // TODO: Animation
        
        view.removeFromSuperview()
        
    }
    
    
    
}
