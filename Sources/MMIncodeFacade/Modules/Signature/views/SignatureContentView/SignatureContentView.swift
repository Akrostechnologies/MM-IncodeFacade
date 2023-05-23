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

    @StateObject var viewModel: SignatureContentViewModel
    let content: () -> Content
    let onClose: () -> Void
    
    // ---------------------------------------------------------------------
    // MARK: Constructor
    // ---------------------------------------------------------------------
    
    init(
        viewModel: SignatureContentViewModel,
        @ViewBuilder content: @escaping () -> Content,
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
                if !viewModel.showModal {
                    DocumentPreview(
                        items: viewModel.getDocuments(),
                        action: { viewModel.showModal.toggle() },
                        onClose: onClose
                    )
                }
            }
        }.easyFullScreenCover(isPresented: $viewModel.showModal) { content() }
    }
}
