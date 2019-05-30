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
}
