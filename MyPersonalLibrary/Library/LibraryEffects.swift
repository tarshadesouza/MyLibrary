//
//  LibraryEffects.swift
//  MyPersonalLibrary
//
//  Created by Tarsha de Souza on 8/9/22.
//

import Foundation
import ComposableArchitecture

func libraryEffect(decoder: JSONDecoder) -> Effect<[Book], APIError> {
  guard let url = URL(string:  "https://openlibrary.org/api/books?bibkeys=ISBN:0201558025,LCCN:93005405&format=json") else {
    fatalError("Error on creating url")
  }
  return URLSession.shared.dataTaskPublisher(for: url)
    .mapError { _ in APIError.downloadError }
    .map { data, _ in data }
    .decode(type: [Book].self, decoder: decoder)
    .mapError { _ in APIError.decodingError }
    .eraseToEffect()
}

func exampleLibraryEffect(decoder: JSONDecoder) -> Effect<[Book], APIError> {
  let exampleLibrary = Book.samples

  return Effect(value: exampleLibrary)
}

func findBookRequestEffect(decoder: JSONDecoder) -> Effect<Book, APIError> {
    let foundBook = Book(title: "Why we sleep", author: "Matthew Walker", isbn: "9780141983769", pages: 368)
    return Effect(value: foundBook)
}
