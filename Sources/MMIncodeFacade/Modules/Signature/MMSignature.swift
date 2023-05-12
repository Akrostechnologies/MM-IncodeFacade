//
//  MMSignature.swift
// MMIncodeFacadeTests
//
//  Created by Andres Lozano on 9/05/23.
//

import SwiftUI
import Combine
import IncdOnboarding

final class MMSignature {
    
    // ---------------------------------------------------------------------
    // MARK: Properties
    // ---------------------------------------------------------------------
    
    private let flowConfiguration: IncdOnboardingFlowConfiguration
    private let item: SignatureModel
    private lazy var container = IncodeContainerView()
    
    // ---------------------------------------------------------------------
    // MARK: Constructor
    // ---------------------------------------------------------------------
    
    init(flowConfiguration: IncdOnboardingFlowConfiguration, item: SignatureModel) {
        self.flowConfiguration = flowConfiguration
        self.item = item
        setup()
    }
    
    // ---------------------------------------------------------------------
    // MARK: Helper vars
    // ---------------------------------------------------------------------
    
    var containerView: some View {
        container
    }
    
    // ---------------------------------------------------------------------
    // MARK: Helper funcs
    // ---------------------------------------------------------------------
    
    func startSignature(
        with configuration: IncdOnboardingSessionConfiguration,
        delegate: IncdOnboardingDelegate?
    ) {
        IncdOnboardingManager.shared.startOnboarding(
            sessionConfig: configuration,
            flowConfig: flowConfiguration,
            delegate: delegate
        )
    }
    
    private func setup() -> Void {
        flowConfiguration.addSignature(
            title: item.title,
            description: item.description,
            descriptionMaxLines: item.maxlinesDescription,
            documents: buildDocuments()
        )
    }
    
    private func buildDocuments() -> [SignDocument] {
        item.documents.map {
            SignDocument(
                title: $0.title,
                fileURL: $0.getURL(),
                signaturePositions: []
            )
        }
    }
}
