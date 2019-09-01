//
//  AuthPlugin.swift
//  FormBuilder
//
//  Created by OrbitRemit LAP048 on 12/08/19.
//  Copyright © 2019 OrbitRemit. All rights reserved.
//

import Foundation
import Moya
import Result
import LocalAuthentication

final class AuthPlugin: PluginType {
  
  func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
    var request = request
    request.addValue("Bearer " + "ef7c7a0afffede9f614f7fdf6f1e7a7495e1bec4", forHTTPHeaderField: "Authorization")
    return request
  }
  
  func process(_ result: Result<Response, MoyaError>, target: TargetType) ->
    Result<Response, MoyaError> {
      let response: Response
      if let error = result.error,
        let r = error.response {
        response = r
      } else if let r = result.value {
        response = r
      } else {
        return result
      }
      
      guard let parsed =
        try? response.map(BackendResponse<BackendError>.self),
        let message = parsed.data?.message,
        parsed.status == "error", parsed.code != 401 else {
          if 200...299 ~= response.statusCode {
            return result
          } else {
            return Result(error: MoyaError.statusCode(response))
          }
      }
      
      let newError = AlertError(title: message)
      return Result(error: MoyaError.underlying(newError, response))
  }
}
