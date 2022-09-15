//
//  LibraryFeature.swift
//  MyPersonalLibrary
//
//  Created by Tarsha de Souza on 8/9/22.
//
import Foundation
import Combine
import ComposableArchitecture

struct LibraryState: Equatable {
  var myBooks: [Book] = []
}

enum LibraryAction: Equatable {
  case onAppear
  case dataLoaded(Result<[Book], APIError>)
  case bookFound(Result<Book, APIError>)
  case addBook
  case removeBook(Book)
  case getLibrary
}

struct LibraryEnvironment {
  var findBookRequest: (JSONDecoder) -> Effect<Book, APIError>
  var loadLibrary: (JSONDecoder) -> Effect<[Book], APIError>
}

let libraryReducer = Reducer<
    LibraryState,
    LibraryAction,
  SystemEnvironment<LibraryEnvironment>
> { state, action, environment in
  switch action {
  case .onAppear:
      //load books from icloud or keychain?
      
      return environment.loadLibrary(environment.decoder())
          .receive(on: environment.mainQueue())
          .catchToEffect()
          .map(LibraryAction.dataLoaded)
      
  case .dataLoaded(let result):
    switch result {
    case .success(let books):
      state.myBooks = books
    case .failure(let error):
    print("!!There was a decoding error \(error)!!")
      break
    }
    return .none
      
  case .bookFound(let result):
      switch result {
      case .success(let book):
          state.myBooks.append(book)
      case .failure(let error):
        break
      }
      return .none
      
  case .addBook:
      return environment.findBookRequest(environment.decoder())
        .receive(on: environment.mainQueue())
        .catchToEffect()
        .map(LibraryAction.bookFound)
      
  case .removeBook(let book):
    if state.myBooks.contains(book) {
      state.myBooks.removeAll { $0 == book }
    }
    return .none
      
  case .getLibrary:
      return environment.loadLibrary(environment.decoder())
          .receive(on: environment.mainQueue())
          .catchToEffect()
          .map(LibraryAction.dataLoaded)
  }
}

