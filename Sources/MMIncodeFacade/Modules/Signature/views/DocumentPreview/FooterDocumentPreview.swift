//
//  FooterView.swift
//  
//
//  Created by Andres Lozano on 22/05/23.
//

import SwiftUI

struct FooterDocumentPreview: View {
    
    // ---------------------------------------------------------------------
    // MARK: States
    // ---------------------------------------------------------------------
    
    @State private var showView = false
    
    // ---------------------------------------------------------------------
    // MARK: Properties
    // ---------------------------------------------------------------------
    
    private var isLastItem: Bool
    private var action: (() -> Void)?
    private var items:[DocumentModel]
    private var onClose: (() -> Void)?
    
    // ---------------------------------------------------------------------
    // MARK: Constructor
    // ---------------------------------------------------------------------
    
    init(isLastItem: Bool, action: (() -> Void)? = nil, items: [DocumentModel], onClose: (() -> Void)?) {
        self.isLastItem = isLastItem
        self.action = action
        self.items = items
        self.onClose = onClose
    }
    
    // ---------------------------------------------------------------------
    // MARK: View
    // ---------------------------------------------------------------------
    
    var body: some View {
        ZStack {
            navigationLink
            VStack(spacing: 20) {
                buttons
            }.font(Font.system(size: 16, weight: .semibold))
        }
    }
    
    // ---------------------------------------------------------------------
    // MARK: Helper views
    // ---------------------------------------------------------------------
    
    @ViewBuilder
    var navigationLink: some View {
        NavigationLink("", isActive: $showView) {
            DocumentPreview(items: items, action: action, onClose: onClose)
        }.hidden()
    }
    
    @ViewBuilder
    var buttons: some View {
        Button {
            !isLastItem ? (showView = true) : action?()
        } label: {
            Text("incdOnboarding.signature.signDocument.acceptButton")
                .padding(16)
                .frame(maxWidth: .infinity)
        }
        .foregroundColor(DefaultMMTheme.colors.background)
        .background(DefaultMMTheme.colors.accent)
        .cornerRadius(50)
        
        Button {
            onClose?()
        } label: {
            Text("incdOnboarding.signature.signDocument.declineButton")
                .foregroundColor(DefaultMMTheme.colors.accent)
                .overlay(DefaultMMTheme.colors.accent.frame(height: 1).offset(y: 14))
        }.padding(.bottom, 30)
    }
}
