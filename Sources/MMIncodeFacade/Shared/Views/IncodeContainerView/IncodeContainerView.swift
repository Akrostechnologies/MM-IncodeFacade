//
//  IncodeContainerView.swift
// MMIncodeFacade
//
//  Created by Andres Lozano on 9/05/23.
//

import Foundation
import SwiftUI
import UIKit
import IncdOnboarding

struct IncodeContainerView: UIViewControllerRepresentable {
    
    // ---------------------------------------------------------------------
    // MARK: UIViewControllerRepresentable
    // ---------------------------------------------------------------------
    

    func makeUIViewController(context: Context) -> UIViewController {
        return UIViewController()
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        IncdOnboardingManager.shared.presentingViewController = uiViewController
    }
    
    public typealias UIViewControllerType = UIViewController
}
