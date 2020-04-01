//
//  Petal.swift
//  Sakura
//
//  Created by Corey Roberts on 3/30/20.
//

import Foundation

public final class Petal {

    // MARK: - Properties

    let destinationView: UIView
    let message: Message
    let style: PetalStyle

    // MARK: - Initializers

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
