//
//  BackendResponse.swift
//  FormBuilder
//
//  Created by OrbitRemit LAP048 on 30/05/19.
//  Copyright © 2019 OrbitRemit. All rights reserved.
//

import Foundation

struct BackendResponse<T>: Codable where T: Codable {
  var status: String?
  var code: Int?
  var data: T?
  
  init(data: T) {
    self.data = data
  }
}

struct BackendArrayResponse<T>: Codable where T: Codable {
  var status: String?
  var code: Int?
  var data: [T]?
  var pagination: Pagination?
  
  init(data: [T]) {
    self.data = data
  }
}

struct BackendJSONAPIResponse<T>: Codable where T: Codable {
  var type: String?
  var id: String?
  var links: [String: String]?
  var attributes: T?
  
  init(attributes: T) {
    self.attributes = attributes
  }
}

struct BackendJSONAPIArrayResponse<T>: Codable where T: Codable {
  var type: String?
  var id: String?
  var links: [String: String]?
  var attributes: [T]?
  
  init(attributes: [T]) {
    self.attributes = attributes
  }
}

struct Pagination: Codable {
  var total: Int?
  var perPage: Int?
  var currentPage: Int?
  var from: Int?
  var to: Int?
  
  init(total: Int, from: Int, to: Int) {
    self.total = total
    self.from = from
    self.to = to
  }
  
  enum CodingKeys: String, CodingKey {
    case total = "total"
    case perPage = "per_page"
    case currentPage = "current_page"
    case from = "from"
    case to = "to"
  }
}
