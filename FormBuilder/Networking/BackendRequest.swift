//
//  BackendRequest.swift
//  FormBuilder
//
//  Created by OrbitRemit LAP048 on 30/05/19.
//  Copyright © 2019 OrbitRemit. All rights reserved.
//

import Foundation
import Moya
import Alamofire

enum BackendPath: CustomStringConvertible {
  case form
  case recipients
  case remote(String)
  
  var description: String {
    switch self {
    case .form:
      return "form.json"
    case .recipients:
      return "recipients.json"
    case .remote(let path):
      return path
    }
  }
}

struct BackendRequest: TargetType {
  var headers: [String: String]?
  
  let path: String
  let method: HTTPMethod
  let parameters: [String: Any]?
  let task: Task
  let parameterEncoding: ParameterEncoding
  
  init(path: BackendPath, method: HTTPMethod = .get,
       parameters: [String: Any]? = nil,
       parameterEncoding: ParameterEncoding = JSONEncoding()) {
    self.path = path.description
    self.method = method
    self.parameters = parameters
    if let p = parameters {
      self.task = .requestParameters(parameters: p, encoding: parameterEncoding)
    } else {
      self.task = .requestPlain
    }
    self.parameterEncoding = parameterEncoding
  }
  
  var baseURL: URL {
    return URL(string: "https://secure.staging.orbitremit.io/api/v2/")!
  }
  
  var sampleData: Data {
    let url = Bundle.main.url(forResource: requestKey(), withExtension: "json")!
    return try! Data(contentsOf: url)
  }
  
  func requestKey(shouldContainParameters: Bool = false) -> String {
    var key = path.replacingOccurrences(of: "/", with: ".")
    key.append(".\(method.rawValue)")
    
    if shouldContainParameters,
      let dict = parameters as? [String: CustomStringConvertible] {
      var c = URLComponents()
      
      c.queryItems = dict.map { (k, v) in
        return URLQueryItem(name: k, value: v.description)
      }
      
      if let paremetersString = c.string {
        key.append(paremetersString)
      }
    }
    return key
  }

  static func getForm(for request: FormRequest) -> BackendRequest {
    let attributes = [
      "form": request.form,
      "recipient_type": request.recipientType,
      "send_currency": request.send,
      "payout_currency": request.payout] as [String: Any]
    let data = [
      "type": "forms",
      "attributes": attributes] as [String : Any]
    let p = ["data": data] as [String : Any]
    return BackendRequest(path: .form, method: .post, parameters: p)
  }
  
  static func getRecipients() -> BackendRequest {
    return BackendRequest(path: .recipients)
  }
  
  static func getRemote(path: String, parameters: [String: Any]? = nil) -> BackendRequest {
    guard let p = parameters else {
      return BackendRequest(path: .remote(path))
    }
    return BackendRequest(path: .remote(path), parameters: p, parameterEncoding: URLEncoding())
  }
}
