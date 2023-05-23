//
//  ContainView.swift
//  
//
//  Created by Andres Lozano on 22/05/23.
//

import SwiftUI

struct DocumentPreview: View {
    
    typealias CallBack = () -> Void
    
    // ---------------------------------------------------------------------
    // MARK: Properties
    // ---------------------------------------------------------------------

    private let radius: CGFloat = 5
    private let viewModel: DocumentPreViewModel
    private var action: CallBack?
    private var onClose: CallBack?

    // ---------------------------------------------------------------------
    // MARK: Constructor
    // ---------------------------------------------------------------------

    init(items: [DocumentModel], action: CallBack? = nil, onClose: CallBack?) {
        self.action = action
        self.onClose = onClose
        viewModel = .init(documents: items)
    }
    
    // ---------------------------------------------------------------------
    // MARK: View
    // ---------------------------------------------------------------------

    var body: some View {
        
        VStack(spacing: 40) {
            bodyView(url: viewModel.currentURL)
            FooterDocumentPreview(
                isLastItem: viewModel.isLastItem(),
                action: action,
                items: viewModel.getItemsForNextPreview(),
                onClose: onClose
            )
        }
        .padding(.horizontal, 20)
        .padding(.top, 20)
        .background(DefaultMMTheme.colors.background.ignoresSafeArea())
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }
    
    // ---------------------------------------------------------------------
    // MARK: Helper views
    // ---------------------------------------------------------------------

    @ViewBuilder
    func bodyView(url: URL) -> some View {
        GeometryReader { proxy in
            PDFKitView(showing: url)
            .cornerRadius(radius)
            .overlay(
                RoundedRectangle(cornerRadius: radius)
                    .stroke(DefaultMMTheme.colors.primary.opacity(0.4), lineWidth: 2)
                    .shadow(color: DefaultMMTheme.colors.background, radius: 8, x: 0, y: 4)
            )
        }
    }
}
