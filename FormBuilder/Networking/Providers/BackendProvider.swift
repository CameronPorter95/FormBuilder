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
import SwiftyJSON

final class BackendProvider: MoyaProvider<BackendRequest> {
  lazy var formProvider: FormProvider = {
    return FormProvider(provider: self)
  }()
  lazy var recipientProvider: RecipientProvider = {
    return RecipientProvider(provider: self)
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
  
  func futureObject<T: Codable>(_ target: BackendRequest, reauth: Bool = true, isJsonApi: Bool = false) -> MoyaFuture<T> {
    return future(target).flatMap { r -> MoyaResult<T> in
      let response = isJsonApi ? r.flattened : r
      let result: MoyaResult<T> = response.mapObject().flatMap { (br: BackendResponse<T>) in
        guard let data = br.data else {
          return Result(error: MoyaError.jsonMapping(r))
        }
        return Result(value: data)
      }
      return result
    }
  }
  
  func futureArray<T: Codable>(_ target: BackendRequest, reauth: Bool = true, isJsonApi: Bool = false) -> MoyaFuture<[T]> {
    return future(target).flatMap { r -> MoyaResult<[T]> in
      let response = isJsonApi ? r.flattened : r
      let result: MoyaResult<[T]> = response.mapObject().flatMap { (br: BackendArrayResponse<T>) in
        guard let data = br.data else {
          return Result(error: MoyaError.jsonMapping(r))
        }
        return Result(value: data)
      }
      return result
    }
  }
}
