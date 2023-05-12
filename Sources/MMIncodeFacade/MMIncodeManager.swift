//
// MMIncodeFacadeManager.swift
// MMIncodeFacade
//
//  Created by Andres Lozano on 9/05/23.
//

import SwiftUI
import IncdOnboarding
import Combine

final public class MMIncodeManager {
    
    public typealias Completation = ((Bool?, IncdOnboarding.IncdInitError?) -> Void)
    
    // ---------------------------------------------------------------------
    // MARK: Properties
    // ---------------------------------------------------------------------
    
    private var signatureFeature: MMSignature?
    public var onFinishFlow = PassthroughSubject<FlowStatus, Never>()
    var cancellables = Set<AnyCancellable>()
    var isActiveFLow = false
    
    // ---------------------------------------------------------------------
    // MARK: Constants
    // ---------------------------------------------------------------------
    
    public static let regionCode: String = "ALL"
    private let dispatchGroup = DispatchGroup()
    
    // ---------------------------------------------------------------------
    // MARK: Constructor
    // ---------------------------------------------------------------------
    
    public init(_ params: INCodeParams, completation: Completation? = nil) {
        setupInit(params: params, completation: completation)
    }
    
    // ---------------------------------------------------------------------
    // MARK: Helper vars
    // ---------------------------------------------------------------------
    
    private var onboardingSessionConfiguration: IncdOnboardingSessionConfiguration {
        IncdOnboardingSessionConfiguration(
            regionCode: Self.regionCode,
            queue: IncdOnboardingManager.shared.queue
        )
    }
    
    private var flowConfiguration: IncdOnboardingFlowConfiguration {
        IncdOnboardingFlowConfiguration()
    }
    
    // ---------------------------------------------------------------------
    // MARK: Helper funcs
    // ---------------------------------------------------------------------
    
    private func setupInit(params: INCodeParams, completation: Completation?) {
        IncdOnboardingManager.shared.initIncdOnboarding(
            url: params.urlString,
            apiKey: params.apiKey,
            loggingEnabled: true,
            testMode: params.testMode,
            completation
        )
        IncdOnboardingManager.shared.sdkMode = .standard
    }
    
    public func presentSignature(item: SignatureModel) -> some View {
        guard !isActiveFLow else { return signatureFeature!.containerView }
        isActiveFLow = true
        let flowConfiguration = flowConfiguration
        signatureFeature = .init(
            flowConfiguration: flowConfiguration,
            item: item
        )
        signatureFeature?.startSignature(
            with: onboardingSessionConfiguration,
            delegate: self
        )
        return signatureFeature!.containerView
    }
}


extension MMIncodeManager: IncdOnboardingDelegate {
    
    // ---------------------------------------------------------------------
    // MARK: IncdOnboardingDelegate
    // ---------------------------------------------------------------------
    
    public func onSuccess() {
        onFinishFlow.send(.success)
        isActiveFLow = false
    }
    
    public func onError(_ error: IncdOnboarding.IncdFlowError) {
        onFinishFlow.send(.error(message: error.description))
        isActiveFLow = false
    }
}

public extension MMIncodeManager {
    
    // ---------------------------------------------------------------------
    // MARK: Enums
    // ---------------------------------------------------------------------
    
    enum FlowStatus {
        case success
        case error(message: String)
    }
}
