//
//  SignatureContentViewModel.swift
//
//  Created by Andres Lozano on 22/05/23.
//

import Foundation
import Combine
import IncdOnboarding

class SignatureContentViewModel: ObservableObject {
    
    // ---------------------------------------------------------------------
    // MARK: Properties
    // ---------------------------------------------------------------------
    
    var lastError: String?
    var signatureModel: SignatureModel
    var onFinishFlow = PassthroughSubject<FlowStatus, Never>()
    @Published var showingAlertError = false
    
    // ---------------------------------------------------------------------
    // MARK: Publishers
    // ---------------------------------------------------------------------
    
    @Published var showModal: Bool = false
    
    // ---------------------------------------------------------------------
    // MARK: Constructor
    // ---------------------------------------------------------------------
    
    init(signature: SignatureModel) {
        self.signatureModel = signature
    }
    
    // ---------------------------------------------------------------------
    // MARK: Helper funcs
    // ---------------------------------------------------------------------

    func setup() {
        showSignature()
    }
    
    func getDocuments() -> [DocumentModel] {
        return signatureModel.documents
    }
    
    func showSignature() {
        showModal = signatureModel.documents.isEmpty
    }
    
    func showIncode() {
        lastError = nil
        showingAlertError = false
        showModal = true
    }
    
    func cancelByUser() {
        showingAlertError = false
        finishFlow(with: .userFinish(error: lastError))
    }
    
    private func finishFlow(with status: FlowStatus, showModal: Bool = false) {
        DispatchQueue.main.async {
            self.onFinishFlow.send(status)
            self.showModal = showModal
        }
    }
}


extension SignatureContentViewModel: IncdOnboardingDelegate {
    
    // ---------------------------------------------------------------------
    // MARK: IncdOnboardingDelegate
    // ---------------------------------------------------------------------
    
    public func onSuccess() { }
    
    public func onError(_ error: IncdOnboarding.IncdFlowError) {
        DispatchQueue.main.async {
            self.lastError = error.description
            self.showingAlertError = true
            self.onFinishFlow.send(.error(reason: error.description))
        }
    }
    
    public func onSignatureCollected(_ result: SignatureFormResult) {
        
        guard let error = result.error else {
            return finishFlow(with: .success(signature: signatureModel))
        }
        
        switch error {
            case .declinedToSignDocument:
                finishFlow(with: .userFinish(error: nil))
            case .error(let error):
                finishFlow(with: .error(reason: error.description))
            @unknown default:
                finishFlow(with: .error(reason: "Something whent wrong"))
        }
    }
    
    func userCancelledSession() {
        showingAlertError = false
        showModal = false
    }
}
