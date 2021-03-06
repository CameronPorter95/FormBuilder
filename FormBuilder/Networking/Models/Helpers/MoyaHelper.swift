//
//  MoyaHelper.swift
//  FormBuilder
//
//  Created by OrbitRemit LAP048 on 30/05/19.
//  Copyright © 2019 OrbitRemit. All rights reserved.
//

import Foundation
import Moya
import BrightFutures
import Result

typealias MoyaFuture<T> = Future<T, MoyaError>
typealias MoyaResult<T> = Result<T, MoyaError>

extension MoyaProvider {
  func future(_ target: Target) -> MoyaFuture<Response> {
    let future = Future { complete in
      request(target) {
        complete($0)
      }
    }
    return future
  }
  
  func wrap(error: Error) -> MoyaError {
    return .underlying(error, nil)
  }
}

extension Response {
  func mapObject<T: Decodable>() -> MoyaResult<T> {
    do {
      return Result(value: try map(T.self))
    } catch let e as MoyaError {
      return Result(error: e)
    } catch {
      return Result(error: MoyaError.underlying(error, nil))
    }
  }
}
