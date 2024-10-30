//
//  PDFKitView.swift
//
//  Created by Andres Lozano on 22/05/23.
//

import SwiftUI
import PDFKit

struct PDFKitView: UIViewRepresentable {

    // ---------------------------------------------------------------------
    // MARK: Properties
    // ---------------------------------------------------------------------

    var dataContent: Data

    // ---------------------------------------------------------------------
    // MARK: Constructor
    // ---------------------------------------------------------------------

    init(dataContent: Data) {
        self.dataContent = dataContent
    }

    // ---------------------------------------------------------------------
    // MARK: UIViewRepresentable
    // ---------------------------------------------------------------------

    func makeUIView(context: Context) -> PDFView {
        let pdfView = PDFView()
        pdfView.backgroundColor = DefaultMMTheme.colors.primary.toUIColor

        DispatchQueue.global(qos: .utility).async {
            let document =  PDFDocument(data: dataContent)
            DispatchQueue.main.async {
                pdfView.document = document
            }
        }
        pdfView.autoScales = true
        return pdfView
    }

    func updateUIView(_ uiView: PDFView, context: Context) { }

    typealias UIViewType = PDFView
}
