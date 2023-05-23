//
//  IncodeParams.swift
// MMIncodeFacade
//
//  Created by Andres Lozano on 9/05/23.
//

import Foundation

public struct IncodeParams {
    
    // ---------------------------------------------------------------------
    // MARK: Properties
    // ---------------------------------------------------------------------
    
    let urlString: String
    let apiKey: String
    let testMode: Bool
    
    // ---------------------------------------------------------------------
    // MARK: Constructor
    // ---------------------------------------------------------------------
    
    public init(
        urlString: String,
        apiKey: String,
        testMode: Bool = true
    ) {
        self.urlString = urlString
        self.apiKey = apiKey
        self.testMode = testMode
    }
}
