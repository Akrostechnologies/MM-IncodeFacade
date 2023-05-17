//
//  File.swift
//  
//
//  Created by Andres Lozano on 17/05/23.
//

import Foundation
import UIKit
import SwiftUI
import IncdOnboarding

public struct ThemeColors {
    
    // ---------------------------------------------------------------------
    // MARK: Properties
    // ---------------------------------------------------------------------
    
    let accent: Color
    let primary: Color
    let background: Color
    let cancel: Color
    let disabled: Color
    
    
    // ---------------------------------------------------------------------
    // MARK: Constructor
    // ---------------------------------------------------------------------
    
    public init(accent: SwiftUI.Color, primary: SwiftUI.Color, background: SwiftUI.Color, cancel: SwiftUI.Color, disabled: SwiftUI.Color) {
        self.accent = accent
        self.primary = primary
        self.background = background
        self.cancel = cancel
        self.disabled = disabled
    }
    
    // ---------------------------------------------------------------------
    // MARK: Helper funcs
    // ---------------------------------------------------------------------
    
    func toThemeConfiguration() -> IncdOnboarding.ColorsConfiguration {
        .init(
            accent: accent.toUIColor,
            primary: primary.toUIColor,
            background: background.toUIColor,
            cancel: cancel.toUIColor,
            disabled: disabled.toUIColor
        )
    }
}
