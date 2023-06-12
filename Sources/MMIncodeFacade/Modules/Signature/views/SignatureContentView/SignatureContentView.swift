//
//  File.swift
//  
//
//  Created by Andres Lozano on 22/05/23.
//

import SwiftUI

struct SignatureContentView<Content: View>: View {
    
    // ---------------------------------------------------------------------
    // MARK: Properties
    // ---------------------------------------------------------------------
    private let colors = DefaultMMTheme.colors
    @StateObject var viewModel: SignatureContentViewModel
    let content: () -> Content?
    let onClose: () -> Void
    
    // ---------------------------------------------------------------------
    // MARK: Constructor
    // ---------------------------------------------------------------------
    
    init(
        viewModel: SignatureContentViewModel,
        @ViewBuilder content: @escaping () -> Content?,
        onClose: @escaping () -> Void
    ) {
        self._viewModel = .init(wrappedValue: viewModel)
        self.content = content
        self.onClose = onClose
    }
    
    // ---------------------------------------------------------------------
    // MARK: View
    // ---------------------------------------------------------------------
    
    var body: some View {
        NavigationView {
            ZStack {
                DocumentPreview(
                    items: viewModel.getDocuments(),
                    action: {
                        viewModel.showIncode()
                    },
                    onClose: onClose
                )
                
//                if viewModel.showModal { containerPresentingIncodeView }
            }
            
            .onAppear { viewModel.setup() }
        }.easyFullScreenCover(isPresented: $viewModel.showModal) {
            containerPresentingIncodeView
                .alert(isPresented: $viewModel.showingAlertError) { alertError }
        }
    }
    
    @ViewBuilder
    var containerPresentingIncodeView: some View {
        ZStack {
            Color.clear.ignoresSafeArea()
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: colors.accent))
                .scaleEffect(2.5)
                .font(.system(size: 16, weight: .heavy))
            if !viewModel.showingAlertError {
                content()
            }
        }
        .background(BackgroundBlurView().ignoresSafeArea())
        .zIndex(10000)
    }
    
    
    var alertError: Alert {
        Alert(
            title: Text("incdOnboarding.signature.error.title"),
            message: Text("incdOnboarding.signature.error.message"),
            primaryButton: .default(Text("incdOnboarding.signature.error.firstButton")) {
                viewModel.showIncode()
            },
            secondaryButton: .default(Text("incdOnboarding.signature.error.defaultButton"), action: {
                viewModel.cancelByUser()
            })
        )
    }
}
