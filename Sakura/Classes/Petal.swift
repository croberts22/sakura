//
//  Petal.swift
//  Sakura
//
//  Created by Corey Roberts on 3/30/20.
//

import Foundation

public final class Petal {

    // MARK: - Properties

    public let message: Message
    public let style: PetalStyle
    public let height: CGFloat

    // MARK: - Initializers

    public init(message: Message, style: PetalStyle, height: CGFloat = 44.0) {
        self.message = message
        self.style = style
        self.height = height
    }

}
