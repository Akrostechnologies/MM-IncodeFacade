//
//  DocumentModel.swift
// MMIncodeFacade
//
//  Created by Andres Lozano on 9/05/23.
//

import Foundation
import IncdOnboarding

public struct DocumentModel {
    
    // ---------------------------------------------------------------------
    // MARK: Properties
    // ---------------------------------------------------------------------

    public let id: UUID = .init()
    let title: String
    public let byteArray: [UInt8]

    // ---------------------------------------------------------------------
    // MARK: Constructor
    // ---------------------------------------------------------------------

    public init(title: String, byteArray: [UInt8]) {
        self.title = title
        self.byteArray = byteArray
    }
}
