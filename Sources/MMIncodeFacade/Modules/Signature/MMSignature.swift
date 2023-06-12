//
//  MMSignature.swift
// MMIncodeFacadeTests
//
//  Created by Andres Lozano on 9/05/23.
//

import IncdOnboarding

final class MMSignature {
    
    // ---------------------------------------------------------------------
    // MARK: Properties
    // ---------------------------------------------------------------------
    
    let item: SignatureModel
    private let flowConfiguration: IncdOnboardingFlowConfiguration
    lazy var containerView = PresentingIncodeView {
        IncdOnboardingManager.shared.presentingViewController = $0
    }
    
    // ---------------------------------------------------------------------
    // MARK: Constructor
    // ---------------------------------------------------------------------
    
    init(flowConfiguration: IncdOnboardingFlowConfiguration, item: SignatureModel) {
        self.flowConfiguration = flowConfiguration
        self.item = item
        setup()
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
            documents: [] //item.documents.toSignDocuments()
        )
    }
}
