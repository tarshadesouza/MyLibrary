//
//  Bookshelf.swift
//  MyPersonalLibrary
//
//  Created by Tarsha de Souza on 15/9/22.
//

import Foundation
/// Bookshelf model is to house different types of genres of books.
struct BookShelf: Codable, Hashable, Identifiable {
  var id = UUID().uuidString
  var userId: String?
  var title: String
  var books = [Book]()
  
  enum CodingKeys: String, CodingKey {
    case id
    case userId
    case title
  }
}

extension BookShelf {
  var count: Int {
    return books.count
  }
}

extension BookShelf {
  static let samples = [
    BookShelf(title: "Currently reading", books: Book.reading),
    BookShelf(title: "Read", books: Book.read),
    BookShelf(title: "Want to read", books: Book.wantToRead)
  ]
}
