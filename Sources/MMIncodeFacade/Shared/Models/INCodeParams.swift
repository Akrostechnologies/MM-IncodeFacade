//
//  INCodeParams.swift
// MMIncodeFacade
//
//  Created by Andres Lozano on 9/05/23.
//

import Foundation

public struct INCodeParams {
    
    let urlString: String
    let apiKey: String
    let testMode: Bool
    
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
