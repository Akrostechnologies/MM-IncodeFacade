//
//  EasyFullScreenCover.swift
//  author: https://github.com/BeeMeeMan/FullScreenCover/tree/main
//  Created by Andres Lozano on 11/05/23.
//

import SwiftUI

public struct EasyFullScreenCover<Content: View>: View {

    // ---------------------------------------------------------------------
    // MARK: Properties
    // ---------------------------------------------------------------------

    @Binding var isPresented: Bool
    @ViewBuilder var content: Content
    
    // ---------------------------------------------------------------------
    // MARK: View
    // ---------------------------------------------------------------------
    
    public var body: some View {
        ZStack {
            content
                .environment(\.easyDismiss, EasyDismiss {
                    isPresented = false
                })
        }
    }
}

struct EasyDismiss {

    // ---------------------------------------------------------------------
    // MARK: Properties
    // ---------------------------------------------------------------------

    private var action: () -> Void
    
    // ---------------------------------------------------------------------
    // MARK: Constructor
    // ---------------------------------------------------------------------

    init(action: @escaping () -> Void = { }) {
        self.action = action
    }
    
    // ---------------------------------------------------------------------
    // MARK: Helper funcs
    // ---------------------------------------------------------------------
    
    func callAsFunction() {
        action()
    }
}

struct EasyDismissKey: EnvironmentKey {
    
    // ---------------------------------------------------------------------
    // MARK: EnvironmentKey
    // ---------------------------------------------------------------------

    public static var defaultValue: EasyDismiss = EasyDismiss()
}

extension EnvironmentValues {
    var easyDismiss: EasyDismiss {
        get { self[EasyDismissKey.self] }
        set { self[EasyDismissKey.self] = newValue }
    }
}
