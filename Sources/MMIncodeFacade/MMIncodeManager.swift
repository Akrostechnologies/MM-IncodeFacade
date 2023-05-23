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
    
    private var signatureFeature: MMSignature!
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
    
    public init(
        _ params: INCodeParams,
        themeColors: ThemeColors = DefaultMMTheme.colors,
        completation: Completation? = nil
    ) {
        DefaultMMTheme.colors = themeColors
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
        IncdTheme.current = DefaultMMTheme.buildTheme()
        IncdOnboardingManager.shared.allowUserToCancel = true
    }
    
    public func presentSignature(item: SignatureModel) -> some View {
        guard !isActiveFLow else { return signatureFeature.containerView }
        isActiveFLow = true
        signatureFeature = .init(
            flowConfiguration: flowConfiguration,
            item: item
        )
        signatureFeature.startSignature(
            with: onboardingSessionConfiguration,
            delegate: self
        )
        return signatureFeature.containerView
    }
    
    public func presentSignatureWithPreview(item: SignatureModel?) -> some View {
        guard let item else {
            finishFLow(with: .invalidData)
            return AnyView(EmptyView())
        }
        let view = SignatureContentView(viewModel: .init(signature: item)) { [weak self] in
            self?.presentSignature(item: item)
        } onClose: { [weak self] in
            self?.finishFLow(with: .userFinish)
        }
        return AnyView(view)
    }
}


extension MMIncodeManager: IncdOnboardingDelegate {
    
    // ---------------------------------------------------------------------
    // MARK: IncdOnboardingDelegate
    // ---------------------------------------------------------------------
    
    public func onSuccess() { }
    
    public func onError(_ error: IncdOnboarding.IncdFlowError) {
        finishFLow(with: .error(message: error.description))
    }
    
    public func userCancelledSession() {
        finishFLow(with: .userFinish)
    }
    
    public func onSignatureCollected(_ result: SignatureFormResult) {
        
        guard let error = result.error else {
            return finishFLow(with: .success(signature: signatureFeature.item))
        }
        
        switch error {
            case .declinedToSignDocument:
                finishFLow(with: .userFinish)
            case .error(let error):
                finishFLow(with: .error(message: error.description))
            @unknown default:
                finishFLow(with: .error(message: "Something whent wrong"))
        }
    }
    
    private func finishFLow(with status: FlowStatus) {
        onFinishFlow.send(status)
        isActiveFLow = false
    }
}

public extension MMIncodeManager {
    
    // ---------------------------------------------------------------------
    // MARK: Enums
    // ---------------------------------------------------------------------
    
    enum FlowStatus {
        case success(signature: SignatureModel)
        case userFinish
        case error(message: String)
        case invalidData
    }
}
