//
//  File.swift
//  
//
//  Created by Andres Lozano on 22/05/23.
//

import Foundation

class DocumentPreViewModel: ObservableObject {
    
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
    
    var currentURL: URL {
        guard let urlString = currentDocument?.urlString,
              let url = URL(string: urlString) else {
            fatalError("The url cannot be nil")
        }
        return url
    }
    
    // ---------------------------------------------------------------------
    // MARK: Helper funcs
    // ---------------------------------------------------------------------
    
    func isLastItem() -> Bool {
        documents.last?.urlString == currentURL.absoluteString
    }
    
    func getItemsForNextPreview() -> [DocumentModel] {
        _ = documents.removeFirst()
        return documents
    }
}
