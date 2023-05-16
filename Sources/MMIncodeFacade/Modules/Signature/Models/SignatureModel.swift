//
//  SignatureModel.swift
// MMIncodeFacade
//
//  Created by Andres Lozano on 9/05/23.
//

import Foundation

public struct SignatureModel {
    
    // ---------------------------------------------------------------------
    // MARK: Properties
    // ---------------------------------------------------------------------

    let id: String
    let documents: [DocumentModel]
    let title: String?
    let description: String?
    let maxlinesDescription: Int?
    
    // ---------------------------------------------------------------------
    // MARK: Constructor
    // ---------------------------------------------------------------------
    
    public init(
        documents: [DocumentModel],
        title: String? = nil,
        description: String? = nil,
        maxlinesDescription: Int? = nil,
        id: String = UUID().uuidString
    ) {
        self.documents = documents
        self.title = title
        self.description = description
        self.maxlinesDescription = maxlinesDescription
        self.id = id
    }
}
