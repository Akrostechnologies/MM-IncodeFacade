//
//  File.swift
//  
//
//  Created by Andres Lozano on 15/05/23.
//

import Foundation
import IncdOnboarding

extension Array where Element: SignDocument {
    
    func toDocumentModel() -> [DocumentModel] {
        self.map({
            .init(title: $0.title, urlString: $0.fileURL.absoluteString)
        })
    }
}


extension Array where Element == DocumentModel {
    
    func toSignDocuments() -> [SignDocument] {
        self.map{ $0.toSignDocuments() }
    }
}
