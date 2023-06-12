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
    
    private let colors = DefaultMMTheme.colors
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
        
        VStack(spacing: 20) {
            headerView
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
        .navigationBarHidden(false)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) { toolbarButtons }
        }
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
                        .stroke(colors.primary.opacity(0.4), lineWidth: 2)
                        .shadow(color: colors.background, radius: 8, x: 0, y: 4)
                )
        }
    }
    
    @ViewBuilder
    var headerView: some View {
        VStack(spacing: 16) {
            Group {
                Text("incdOnboarding.signature.preview.title")
                    .font(Font.system(size: 28, weight: .semibold))
                
                Text("incdOnboarding.signature.preview.description")
                    .font(Font.system(size: 16, weight: .regular))
            }
            .foregroundColor(colors.primary)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
    
    @ViewBuilder
    var toolbarButtons: some View {
        Button { onClose?() } label: {
            Image("x-mark-icon", bundle: .current)
                .renderingMode(.template)
                .resizable(capInsets: .init(top: 0, leading: 0, bottom: 0, trailing: 0), resizingMode: .stretch)
                .aspectRatio(contentMode: .fill)
                .frame(width: 17, height: 34)
        }.foregroundColor(colors.accent)
    }
}
