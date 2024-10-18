//
//  File.swift
//  
//
//  Created by Andres Lozano on 22/05/23.
//

import Foundation

class DocumentPreViewModel {
    
    // ---------------------------------------------------------------------
    // MARK: Publisers
    // ---------------------------------------------------------------------
    
    @Published var documents: [DocumentModel]
    @Published var currentDocument: DocumentModel?
    
    // ---------------------------------------------------------------------
    // MARK: Constructor
    // ---------------------------------------------------------------------
    
    init(documents: [DocumentModel]) {
        self.documents = documents
        self.currentDocument = documents.first
    }
    
    // ---------------------------------------------------------------------
    // MARK: Helper vars
    // ---------------------------------------------------------------------

    var currentDataContent: Data {
        guard let byteElement = currentDocument?.byteArray else {
            fatalError("The url cannot be nil")
        }

        return Data(byteElement)
    }
    
    // ---------------------------------------------------------------------
    // MARK: Helper funcs
    // ---------------------------------------------------------------------
    
    func isLastItem() -> Bool {
        documents.last?.id == currentDocument?.id
    }
    
    func getItemsForNextPreview() -> [DocumentModel] {
        _ = documents.removeFirst()
        return documents
    }
}
