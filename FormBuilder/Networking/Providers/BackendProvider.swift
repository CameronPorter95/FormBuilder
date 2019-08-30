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
  
  func futureJsonObject<T: JsonStructure>(_ target: BackendRequest, isJsonApi: Bool = false) -> MoyaFuture<T> {
    return future(target).flatMap { r -> MoyaResult<T> in
      let result: MoyaResult<T>!
      if isJsonApi {
        result = r.mapObject().flatMap { (br: BackendResponse<BackendJSONAPIResponse<JSON>>) in
          guard let data = br.data,
            let attributes = data.attributes else {
              return Result(error: MoyaError.jsonMapping(r))
          }
          let jsonStruct = T.init(attributes)
          return Result(value: jsonStruct)
        }
      } else {
        result = r.mapObject().flatMap { (br: BackendResponse<JSON>) in
          guard let data = br.data else {
            return Result(error: MoyaError.jsonMapping(r))
          }
          let jsonStruct = T.init(data)
          return Result(value: jsonStruct)
        }
      }
      return result
    }
  }
  
  func futureJsonArray<T: JsonStructure>(_ target: BackendRequest, isJsonApi: Bool = false) -> MoyaFuture<[T]> {
    return future(target).flatMap { r -> MoyaResult<[T]> in
      let result: MoyaResult<[T]>!
      if isJsonApi {
        result = r.mapObject().flatMap { (br: BackendArrayResponse<BackendJSONAPIResponse<JSON>>) in
          guard let data = br.data else {
            return Result(error: MoyaError.jsonMapping(r))
          }
          let attributes = data.compactMap { (jsonAPI: BackendJSONAPIResponse) in
            return jsonAPI.attributes
          }
          let jsonStructs = attributes.map { T.init($0) }
          return Result(value: jsonStructs)
        }
      } else {
        result = r.mapObject().flatMap { (br: BackendArrayResponse<JSON>) in
          guard let data = br.data else {
            return Result(error: MoyaError.jsonMapping(r))
          }
          let jsonStructs = data.map { T.init($0) }
          return Result(value: jsonStructs)
        }
      }
      return result
    }
  }
}
