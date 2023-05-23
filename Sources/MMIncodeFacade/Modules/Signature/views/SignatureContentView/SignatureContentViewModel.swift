//
//  SignatureContentViewModel.swift
//
//  Created by Andres Lozano on 22/05/23.
//

import Foundation
import Combine

class SignatureContentViewModel: ObservableObject {
    
    // ---------------------------------------------------------------------
    // MARK: Properties
    // ---------------------------------------------------------------------
    
    var signatureModel: SignatureModel
    
    // ---------------------------------------------------------------------
    // MARK: Publishers
    // ---------------------------------------------------------------------
    
    @Published var showModal: Bool = false
    
    // ---------------------------------------------------------------------
    // MARK: Constructor
    // ---------------------------------------------------------------------
    
    init(signature: SignatureModel) {
        self.signatureModel = signature
        showSignature()
    }
    
    // ---------------------------------------------------------------------
    // MARK: Helper funcs
    // ---------------------------------------------------------------------

    func getDocuments() -> [DocumentModel] {
        return signatureModel.documents
    }
    
    func showSignature() {
        showModal = signatureModel.documents.isEmpty
    }
}
