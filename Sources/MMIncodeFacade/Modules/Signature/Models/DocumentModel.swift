//
//  DocumentModel.swift
// MMIncodeFacade
//
//  Created by Andres Lozano on 9/05/23.
//

import Foundation


public struct DocumentModel {
    
    // ---------------------------------------------------------------------
    // MARK: Properties
    // ---------------------------------------------------------------------
    
    let title: String
    let urlString: String
    
    // ---------------------------------------------------------------------
    // MARK: Constructor
    // ---------------------------------------------------------------------
    
    public init(title: String, urlString: String) {
        self.title = title
        self.urlString = urlString
    }
    
    // ---------------------------------------------------------------------
    // MARK: Helper vars
    // ---------------------------------------------------------------------
    
    func getURL() -> URL {
        .init(string: urlString)!
    }
}
