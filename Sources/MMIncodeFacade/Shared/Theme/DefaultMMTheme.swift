//
//  File.swift
//  
//
//  Created by Andres Lozano on 16/05/23.
//

import Foundation
import UIKit
import IncdOnboarding

public struct DefaultMMTheme {
    
    static let fontsConfig = FontsConfiguration(
        title: .systemFont(ofSize: 28, weight: .semibold),
        body: .systemFont(ofSize: 15, weight: .regular),
        buttonBig: .systemFont(ofSize: 15, weight: .semibold),
        buttonMedium: .systemFont(ofSize: 15, weight: .semibold)
    )
    
    
    // ---------------------------------------------------------------------
    // MARK: Properties
    // ---------------------------------------------------------------------
    
    public static var colors = ThemeColors (
        accent: .green,
        primary: .white,
        background: .black,
        cancel: .green,
        disabled: .white.opacity(0.2)
    )
    
    // ---------------------------------------------------------------------
    // MARK: Helper funcs
    // ---------------------------------------------------------------------
    
    static func buildTheme() -> IncdOnboarding.ThemeConfiguration {
        return .init(
            colors: colors.toThemeConfiguration(),
            fonts: fontsConfig,
            buttons: .init(
                primary: primaryButton
            ),
            labels: .init(
                title: defaultLabelConfiguration(),
                body: defaultLabelConfiguration()
            ),
            customComponents: .init(
                signature: .init(signatureColor: .white, canvasBorderColor: .white)
            )
        )
    }
    
    // ---------------------------------------------------------------------
    // MARK: Private Helper funcs
    // ---------------------------------------------------------------------
    
    private static var primaryButton: ButtonConfiguration {
        let colors = colors.toThemeConfiguration()
        let height: CGFloat = 50
        let radius = height / 2
        
        let normal = ButtonThemedState(
            backgroundColor: colors.accent,
            cornerRadius: radius,
            shadowColor: .clear,
            shadowOffset: .zero,
            textColor: colors.background
        )
        
        var highlighted = normal
        highlighted.backgroundColor = colors.accent.withAlphaComponent(0.8)
        highlighted.textColor = colors.background
        highlighted.cornerRadius = radius
        
        var disabled = normal
        disabled.backgroundColor = colors.disabled
        disabled.textColor = colors.primary
        disabled.cornerRadius = radius
        
        return .init(
            states: .init(
                normal: normal,
                highlighted: highlighted,
                disabled: disabled
            ),
            big: buttonSize(height: height)
        )
    }
    
    private static func defaultLabelConfiguration() -> LabelConfiguration{
        LabelConfiguration(
            textAlignment: .justified,
            textColor: colors.primary.toUIColor
        )
    }
    
    private static func buttonSize(height: CGFloat = 40, padding: CGFloat = 5) -> ButtonSizeVariant {
        return .init(
            height: height,
            minWidth: (UIScreen.main.bounds.width) - (20 * 2),
            contentInsets: .init(top: padding, left: padding, bottom: padding, right: padding)
        )
    }
}
