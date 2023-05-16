//
//  File.swift
//  
//
//  Created by Andres Lozano on 16/05/23.
//

import Foundation
import IncdOnboarding

public struct DefaultMMTheme {
    
    // ---------------------------------------------------------------------
    // MARK: Properties
    // ---------------------------------------------------------------------
    
    public static var colors = ColorsConfiguration (
        accent: .green,
        primary: .white,
        background: .black,
        secondaryBackground: .white.withAlphaComponent(0.2),
        success: .systemPink,
        error: .blue,
        warning: .orange,
        cancel: .green,
        disabled: .white.withAlphaComponent(0.2)
    )
    
    // ---------------------------------------------------------------------
    // MARK: Helper funcs
    // ---------------------------------------------------------------------
    
    static func buildTheme() -> IncdOnboarding.ThemeConfiguration {
        
        let labelsConfig = LabelsConfiguration(
            title: defaultLabelConfiguration(),
            body: defaultLabelConfiguration()
        )
        
        let buttonsConfig = ButtonsConfiguration(
            primary: primaryButton,
            text: textButton
        )
        
        return .init(
            colors: colors,
            buttons: buttonsConfig,
            labels: labelsConfig,
            customComponents: .init(
                signature: .init(signatureColor: .white, canvasBorderColor: .white)
            )
        )
    }
    
    // ---------------------------------------------------------------------
    // MARK: Private Helper funcs
    // ---------------------------------------------------------------------
    
    private static var primaryButton: ButtonConfiguration {
        let normal = ButtonThemedState(
            backgroundColor: colors.accent,
            cornerRadius: cornerRadius,
            shadowColor: .clear,
            shadowOffset: .zero,
            textColor: colors.background
        )
        
        var highlighted = normal
        highlighted.backgroundColor = colors.accent.withAlphaComponent(0.8)
        highlighted.textColor = colors.background
        highlighted.cornerRadius = cornerRadius
        
        var disabled = normal
        disabled.backgroundColor = colors.disabled
        disabled.textColor = colors.primary
        
        let big = buttonSize(height: 40)
        let medium = buttonSize(height: 30)
        
        return .init(
            states: .init(
                normal: normal,
                highlighted: highlighted,
                disabled: disabled
            ),
            big: big,
            medium: medium
        )
    }
    
    private static var textButton: ButtonConfiguration {
        let normal = ButtonThemedState(
            backgroundColor: .clear,
            cornerRadius: cornerRadius,
            shadowColor: .clear,
            shadowOffset: .zero,
            textColor: colors.accent
        )
        
        var disabled = normal
        disabled.backgroundColor = .clear
        disabled.textColor = colors.disabled
        
        var highlighted = normal
        highlighted.backgroundColor = .clear
        highlighted.cornerRadius = cornerRadius
        
        let big = buttonSize(height: 40)
        let medium = buttonSize(height: 30)
        
        return .init(
            states: .init(
                normal: normal,
                highlighted: highlighted,
                disabled: disabled
            ),
            big: big,
            medium: medium
        )
    }
    
    private static func defaultLabelConfiguration() -> LabelConfiguration{
        LabelConfiguration(
            textAlignment: .justified,
            textColor: colors.primary
        )
    }
    
    private static func buttonSize(height: CGFloat = 40, padding: CGFloat = 5) -> ButtonSizeVariant {
        return .init(
            height: height,
            contentInsets: .init(top: padding, left: padding, bottom: padding, right: padding)
        )
    }
    
    private static let cornerRadius: CGFloat = 24
}
