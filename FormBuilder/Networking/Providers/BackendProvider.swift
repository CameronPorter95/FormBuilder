//
//  BackendProvider.swift
//  FormBuilder
//
//  Created by OrbitRemit LAP048 on 30/05/19.
//  Copyright © 2019 OrbitRemit. All rights reserved.
//

import Foundation
import Moya
import Result

final class BackendProvider: MoyaProvider<BackendRequest> {
  lazy var jsonProvider: JSONProvider = {
    return JSONProvider(provider: self)
  }()
  
  var auth: AuthPlugin? {
    return plugins.first as? AuthPlugin
  }
  
  static func newWithAuthLoggerActivity() -> BackendProvider {
    var ps: [PluginType] = [
      AuthPlugin(),
      NetworkActivityPlugin { change, _ in
        UIApplication.shared.isNetworkActivityIndicatorVisible =
          change == .began
      }
    ]
    
    ps.append(NetworkLoggerPlugin(verbose: true, cURL: true)) 
    return BackendProvider(plugins: ps)
  }
  
  ///Make an HTTP request to get json in a codable format
  func futureObject<T: Codable>(_ target: BackendRequest) -> MoyaFuture<T> {
    let f = future(target)
    return f.flatMap { r -> MoyaResult<T> in
      r.mapObject().flatMap { (br: BackendResponse<T>) in
        guard let data = br.data else {
          return Result(error: MoyaError.jsonMapping(r))
        }
        return Result(value: data)
      }
    }
  }
  
  func futureObject<T: Codable>(_ target: BackendRequest, isJsonAPI: Bool = false) -> MoyaFuture<T> {
    let f = future(target)
    return f.flatMap { r -> MoyaResult<T> in
      r.mapObject().flatMap { (br: BackendResponse<T>) in
        guard let data = br.data else {
          return Result(error: MoyaError.jsonMapping(r))
        }
        let jsonAPI = BackendJSONAPIResponse<T>(attributes: data)
        if isJsonAPI {
          guard let attributes = jsonAPI.attributes else {
            return Result(error: MoyaError.jsonMapping(r))
          }
          return Result(value: attributes)
        }
        return Result(value: data)
      }
    }
  }
}
