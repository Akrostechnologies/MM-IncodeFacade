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

    var url: URL
    
    // ---------------------------------------------------------------------
    // MARK: Constructor
    // ---------------------------------------------------------------------
    
    init(showing url: URL) {
        self.url = url
    }
    
    // ---------------------------------------------------------------------
    // MARK: UIViewRepresentable
    // ---------------------------------------------------------------------
    
    func makeUIView(context: Context) -> PDFView {
        let pdfView = PDFView()
        pdfView.backgroundColor = DefaultMMTheme.colors.primary.toUIColor
        
        DispatchQueue.global(qos: .utility).async {
            let document =  PDFDocument(url: url)
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
