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
    let interviewdId: String
    let token: String

    // ---------------------------------------------------------------------
    // MARK: Constructor
    // ---------------------------------------------------------------------
    
    public init(
        urlString: String,
        apiKey: String,
        testMode: Bool = true,
        interviewId: String,
        token: String
    ) {
        self.urlString = urlString
        self.apiKey = apiKey
        self.testMode = testMode
        self.interviewdId = interviewId
        self.token = token
    }
}
