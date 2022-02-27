//
//  UIFeedback.swift
//  Created by Nikita Mikheev on 28.02.2022.
//

import UIKit

final class UIFeedback {
    // MARK: Dependencies
    private static var generator: UIImpactFeedbackGenerator = {
        UIImpactFeedbackGenerator(style: .heavy)
    }()
    
    // MARK: Interface
    static func vibrate() {
        generator.impactOccurred()
    }
}
