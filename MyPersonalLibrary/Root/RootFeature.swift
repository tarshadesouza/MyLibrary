//
//  RootFeature.swift
//  MyPersonalLibrary
//
//  Created by Tarsha de Souza on 15/9/22.
//

import Foundation
import ComposableArchitecture

struct RootState {
  var libraryState = LibraryState()
}

enum RootAction {
  case libraryAction(LibraryAction)
}

struct RootEnvironment { }

///rootReducer will just pull in together all the differente features that the app can have, it will combine all the publishers that each feature has so that the base state always knows the overall state of the app!
// swiftlint:disable trailing_closure
let rootReducer = Reducer<
  RootState,
  RootAction,
  SystemEnvironment<RootEnvironment>
>.combine(
  // 1
  libraryReducer.pullback(
    // 2
    state: \.libraryState,
    // 3
    action: /RootAction.libraryAction,
    // 4
    environment: { _ in
      .live(
        environment: LibraryEnvironment(findBookRequest: findBookRequestEffect, loadLibrary: libraryEffect))
    }))
// swiftlint:enable trailing_closure
