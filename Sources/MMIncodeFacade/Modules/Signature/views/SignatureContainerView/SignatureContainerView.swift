//
//  File.swift
//  
//
//  Created by Andres Lozano on 23/05/23.
//

import SwiftUI

struct SignatureContainerView: View {
    
    // ---------------------------------------------------------------------
    // MARK: Views
    // ---------------------------------------------------------------------
    
    var contentView: PresentingIncodeView

    // ---------------------------------------------------------------------
    // MARK: View
    // ---------------------------------------------------------------------

    var body: some View {
        ZStack {
            DefaultMMTheme.colors.background.ignoresSafeArea()
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: DefaultMMTheme.colors.accent))
                .scaleEffect(2)
                .font(.system(size:8))
            contentView
        }
    }
}
