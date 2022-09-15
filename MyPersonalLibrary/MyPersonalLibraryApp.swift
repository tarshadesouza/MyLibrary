//
//  MyPersonalLibraryApp.swift
//  MyPersonalLibrary
//
//  Created by Tarsha de Souza on 8/9/22.
//

import SwiftUI
import ComposableArchitecture

@main
struct MyPersonalLibraryApp: App {
    var body: some Scene {
        WindowGroup {
            RootView(
              store: Store(
                initialState: RootState(),
                reducer: rootReducer,
                environment: .live(environment: RootEnvironment())))
        }
    }
}
