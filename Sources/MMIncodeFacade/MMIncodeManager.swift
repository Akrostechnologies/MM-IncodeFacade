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
    
    fileprivate var signatureFeature: MMSignature!
    fileprivate var signatureContentView: SignatureContentView<AnyView>!
    public var onFinishFlow = PassthroughSubject<FlowStatus, Never>()
    var store = Set<AnyCancellable>()
    
    // ---------------------------------------------------------------------
    // MARK: Constants
    // ---------------------------------------------------------------------
    
    public static var regionCode: String = "ALL"
    private let dispatchGroup = DispatchGroup()
    
    // ---------------------------------------------------------------------
    // MARK: Constructor
    // ---------------------------------------------------------------------
    
    public init(
        _ params: IncodeParams,
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
            queue: .defaultQueue
        )
    }
    
    private var flowConfiguration: IncdOnboardingFlowConfiguration {
        IncdOnboardingFlowConfiguration()
    }
    
    // ---------------------------------------------------------------------
    // MARK: Helper funcs
    // ---------------------------------------------------------------------
    
    public func presentSignature(item: SignatureModel?) -> some View {
        let emptyView = AnyView(EmptyView())
        guard let item else {
            finishFlow(with: .invalidData)
            return emptyView
        }
        
        guard signatureContentView == nil else {
            return AnyView(signatureContentView)
        }
        
        let vm = SignatureContentViewModel(signature: item)
        vm.onFinishFlow
            .sink(receiveValue: { [weak self] in self?.finishFlow(with: $0)})
            .store(in: &store)
        
        signatureContentView = .init(viewModel: vm, content: { [weak self] in
            self?.setupSignature(item: item, delegate: vm)
        }, onClose: { [weak self] in
            self?.finishFlow(with: .userFinish(error: nil))
        })
        return AnyView(signatureContentView)
    }
}

extension MMIncodeManager {
    
    // ---------------------------------------------------------------------
    // MARK: Setup
    // ---------------------------------------------------------------------
    
    fileprivate func setupInit(params: IncodeParams, completation: Completation?) {
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
    
    fileprivate func setupSignature(item: SignatureModel, delegate: IncdOnboardingDelegate?) -> AnyView {
        signatureFeature = .init(
            flowConfiguration: flowConfiguration,
            item: item
        )
        signatureFeature.startSignature(
            with: onboardingSessionConfiguration,
            delegate: delegate
        )
        return AnyView(signatureFeature.containerView)
    }
    
    fileprivate func finishFlow(with status: FlowStatus) {
        onFinishFlow.send(status)
        switch status {
            case .error: break
            default:
                signatureContentView = nil
                signatureFeature = nil
        }
    }
}

public enum FlowStatus {
    case success(signature: SignatureModel)
    case userFinish(error: String?)
    case error(reason: String)
    case invalidData
}
