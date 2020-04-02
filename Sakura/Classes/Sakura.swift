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
    private let window: UIWindow
    private let parentView: UIView = UIView()
    private var queue: [Petal] = [Petal]()
    weak var currentPetal: Petal?

    // MARK: - Initializers

    public init(window: UIWindow) {
        self.window = window

        setup()
    }

    convenience public init() {

        guard let window = UIApplication.shared.keyWindow else {
            assertionFailure("This application should have a `keyWindow`.")
            fatalError()
        }

        self.init(window: window)
    }

    // MARK: - Public Methods
    
    public func display(petal: Petal) {
        queue.append(petal)
        currentPetal = petal
        animate(petal: petal)
    }

    // MARK: - Private Methods

    private func setup() {
        setupViews()
        setupConstraints()
    }

    private func setupViews() {
        parentView.translatesAutoresizingMaskIntoConstraints = false
        parentView.isUserInteractionEnabled = false
        parentView.backgroundColor = .blue
        parentView.clipsToBounds = true

        // Add this "hidden" view to the current window.
        // We set the constraints for now to be approximately the height of the navigation bar
        // and then some.
        //
        // I still haven't decided if we should customize this framework to display
        // it elsewhere besides above or under the navigation bar.
        window.addSubview(parentView)
    }

    private func setupConstraints() {
        parentView.topAnchor.constraint(equalTo: window.topAnchor).isActive = true
        parentView.leftAnchor.constraint(equalTo: window.leftAnchor).isActive = true
        parentView.rightAnchor.constraint(equalTo: window.rightAnchor).isActive = true

        // FIXME: Arbitrary constant for now.
        parentView.heightAnchor.constraint(equalToConstant: 200).isActive = true
    }
    
    private func animate(petal: Petal) {
        let sakuraView: SakuraView = SakuraView(petal: petal)
        let animator: UIViewPropertyAnimator = prepare(sakuraView: sakuraView, with: petal)
        animator.startAnimation()
    }
    
    private func prepare(sakuraView: SakuraView, with petal: Petal) -> UIViewPropertyAnimator {
        sakuraView.backgroundColor = .purple

        parentView.addSubview(sakuraView)
        // Maybe set this someday for masking underneath the navigation bar?
//        parentView.maskView(with: window, visibleSize: CGSize(width: window.frame.size.width, height: petal.height))
        
        let topAnchor = sakuraView.topAnchor.constraint(equalTo: parentView.topAnchor, constant: -100.0)
        topAnchor.isActive = true
        
        sakuraView.leftAnchor.constraint(equalTo: parentView.leftAnchor).isActive = true
        sakuraView.rightAnchor.constraint(equalTo: parentView.rightAnchor).isActive = true
        sakuraView.heightAnchor.constraint(equalToConstant: petal.height).isActive = true
        
        parentView.layoutIfNeeded()

        topAnchor.constant = window.rootViewController?.statusBarHeight ?? 30.0
        let animator: UIViewPropertyAnimator = sakuraView.animator {
            self.parentView.layoutIfNeeded()
        }

        animator.addCompletion { (_) in
            let reverseAnimation: UIViewPropertyAnimator = sakuraView.animator {
                topAnchor.constant = -100.0
                self.parentView.layoutIfNeeded()
            }

            reverseAnimation.startAnimation(afterDelay: 3.0)
        }

        return animator
    }

    
}
