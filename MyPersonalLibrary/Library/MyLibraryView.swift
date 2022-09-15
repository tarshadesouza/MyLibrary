//
//  ContentView.swift
//  MyPersonalLibrary
//
//  Created by Tarsha de Souza on 8/9/22.
//

import SwiftUI
import ComposableArchitecture

struct MyLibraryView: View {
    let store: Store<LibraryState, LibraryAction>
    
    var body: some View {
        WithViewStore(self.store) { viewStore in
            ScrollView {
                List(viewStore.myBooks) { book in
                    BookRow(book: book)
                }
            }
         
            .onAppear {
              viewStore.send(.onAppear)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MyLibraryView(store: Store(
            initialState: LibraryState(),
            reducer: libraryReducer,
            environment: .dev(
              environment: LibraryEnvironment(
                findBookRequest: findBookRequestEffect,
                loadLibrary: exampleLibraryEffect))))
    }
}

struct BookRow: View {
    var book: Book

    var body: some View {
        Text("Yours truly\(book.title)")
    }
}
