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
        case .loading: return UIActivityIndicatorView(style: .white)
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



/// A message orchestrator that gently displays messages in full bloom. 🌸
public final class Sakura {

    // MARK: - Properties

    public static let shared: Sakura = Sakura()
    private var queue: [Petal] = [Petal]()
    weak var currentPetal: Petal?

    // MARK: - Initializers
    
    public init() { }

    // MARK: - Public Methods
    
    public func display(petal: Petal) {
        queue.append(petal)
        currentPetal = petal
        animate(petal: petal)
    }

    // MARK: - Private Methods
    
    private func animate(petal: Petal) {
        let sakuraView: SakuraView = SakuraView(petal: petal)
        let animator: UIViewPropertyAnimator = prepare(sakuraView: sakuraView, with: petal)
        animator.startAnimation()
    }
    
    private func prepare(sakuraView: SakuraView, with petal: Petal) -> UIViewPropertyAnimator {
        sakuraView.backgroundColor = .purple
        
        let parentView: UIView = petal.destinationView
        
        parentView.addSubview(sakuraView)
        
        let bottomAnchor = sakuraView.bottomAnchor.constraint(equalTo: parentView.topAnchor, constant: -80.0)
        bottomAnchor.isActive = true
        
        sakuraView.leftAnchor.constraint(equalTo: parentView.leftAnchor).isActive = true
        sakuraView.rightAnchor.constraint(equalTo: parentView.rightAnchor).isActive = true
        sakuraView.heightAnchor.constraint(equalToConstant: 44.0).isActive = true
        
        parentView.layoutIfNeeded()
        
        
        // FIXME: Add constant to Petal enum.
        bottomAnchor.constant = 160.0
        let animator: UIViewPropertyAnimator = sakuraView.animator {
            parentView.layoutIfNeeded()
        }
        
        bottomAnchor.constant = -80.0
        animator.addAnimations({
            animator.isReversed = true
        }, delayFactor: 3.0)
        
        return animator
    }

    
}
