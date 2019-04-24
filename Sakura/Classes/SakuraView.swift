//
//  SakuraView.swift
//  Sakura
//
//  Created by Corey Roberts on 4/17/19.
//

import UIKit

final public class SakuraView: UIView {

    private let contentView: UIView = UIView()
    private let label: UILabel = UILabel()
    private var accessoryView: UIView?
    
    public init(petal: Petal) {
        label.text = petal.message.message
        accessoryView = petal.style.accessoryView
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
    
    public func configure(with petal: Petal) {
        
        label.text = petal.message.message
        
    }
    
}
