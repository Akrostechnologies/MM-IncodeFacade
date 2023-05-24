//
//  IncodeContainerView.swift
// MMIncodeFacade
//
//  Created by Andres Lozano on 9/05/23.
//

import SwiftUI
import UIKit

struct PresentingIncodeView: UIViewControllerRepresentable {
    
    var onPresentingViewController: ((UIViewController) -> Void)?
    
    // ---------------------------------------------------------------------
    // MARK: UIViewControllerRepresentable
    // ---------------------------------------------------------------------

    func makeUIViewController(context: Context) -> UIViewController {
        return UIViewController()
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        onPresentingViewController?(uiViewController)
    }
    
    public typealias UIViewControllerType = UIViewController
}
