//
//  SakuraView.swift
//  Sakura
//
//  Created by Corey Roberts on 4/17/19.
//

import UIKit


/// A view that display messages from a `Petal`.
final public class SakuraView: UIView {

    // MARK: - Properties

    private let contentView: UIView = UIView()
    private let label: UILabel = UILabel()
    private var accessoryView: UIView?

    // MARK: - Initializers

    public init(petal: Petal) {
        label.text = petal.message.message
        accessoryView = petal.style.accessoryView
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public Methods


    /// Configures this view.
    /// - Parameter petal: A `Petal` to configure this view with.
    public func configure(with petal: Petal) {
        label.text = petal.message.message
    }


    /// Provides a default `UIViewPropertyAnimator` for this view.
    /// - Parameter animations: A closure of actions to animate.
    /// - Returns: An `UIViewPropertyAnimator`.
    public func animator(with animations: (() -> Void)? = nil) -> UIViewPropertyAnimator {
        UIViewPropertyAnimator(duration: 1.0, dampingRatio: 0.6, animations: animations)
    }

    // MARK: - Private Methods
    
    private func setup() {
        
        translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(contentView)
        
        contentView.addSubview(label)
        
        if let accessoryView = accessoryView {
            contentView.addSubview(accessoryView)
            accessoryView.translatesAutoresizingMaskIntoConstraints = false
        }
        
        contentView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        contentView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        contentView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        // Debugging
        contentView.backgroundColor = .red
        label.backgroundColor = .green
        
        label.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20.0).isActive = true
        label.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20.0).isActive = true
        label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
    }
    
}
