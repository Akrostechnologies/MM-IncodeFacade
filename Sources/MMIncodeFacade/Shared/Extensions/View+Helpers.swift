//
//  View+Helpers.swift
//  Created by Andres Lozano on 11/05/23.
//

import SwiftUI

public extension View {
    
    func easyFullScreenCover<Content>(
        isPresented: Binding<Bool>,
        transition: AnyTransition = .opacity,
        content: @escaping () -> Content
    ) -> some View where Content : View {
        ZStack {
            self
            ZStack { // for correct work of transition animation
                if isPresented.wrappedValue {
                    EasyFullScreenCover(isPresented: isPresented, content: content)
                        .transition(transition)
                }
            }
        }
    }
}
