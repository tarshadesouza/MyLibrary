//
//  RootView.swift
//  MyPersonalLibrary
//
//  Created by Tarsha de Souza on 15/9/22.
//

import SwiftUI
import ComposableArchitecture

struct RootView: View {
  let store: Store<RootState, RootAction>
  var body: some View {
    WithViewStore(self.store.stateless) { _ in
      TabView {
        MyLibraryView(
          store: store.scope(
            state: \.libraryState,
            action: RootAction.libraryAction))
          .tabItem {
            Image(systemName: "list.bullet")
            Text("Library")
          }
      }
      .accentColor(Color.blue)
    }
  }
}

struct RootView_Previews: PreviewProvider {
  static var previews: some View {
    let rootView = RootView(
      store: Store(
        initialState: RootState(),
        reducer: rootReducer,
        environment: .dev(environment: RootEnvironment())))
    return rootView
  }
}
