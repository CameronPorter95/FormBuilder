//
//  StubsMiddleware.swift
//  App
//
//  Created by OrbitRemit LAP048 on 15/04/19.
//

import FluentSQLite
import Vapor
import Foundation

struct RouteError: Error {
    let message: String
}

final class StubsMiddleware: Middleware {
  public func respond(to request: Request, chainingTo next: Responder) throws -> Future<Response> {
    let projectDir = DirectoryConfig.detect().workDir
    let method = request.http.method
    let path = request.http.url.path.dropFirst().replacingOccurrences(of: "/", with: ".")
    let query = request.http.url.query
    let straightfilePath = URL(fileURLWithPath: projectDir)
      .appendingPathComponent("Stubs", isDirectory: true)
      .appendingPathComponent("\(path).\(method).json", isDirectory: false).path
    
    let queryfilePath = URL(fileURLWithPath: projectDir)
      .appendingPathComponent("Stubs", isDirectory: true)
      .appendingPathComponent("\(path)?\(query ?? "").\(method).json", isDirectory: false).path
    
    var isDir: ObjCBool = false
    if FileManager.default.fileExists(atPath: queryfilePath, isDirectory: &isDir) {
      print(queryfilePath)
      return try request.streamFile(at: queryfilePath)
    } else {
      if FileManager.default.fileExists(atPath: straightfilePath, isDirectory: &isDir) {
        print(straightfilePath)
        return try request.streamFile(at: straightfilePath)
      } else {
        print("couldn't find any files")
        return try next.respond(to: request)
      }
    }
  }
}

extension StubsMiddleware: ServiceType {
    static func makeService(for worker: Container) throws -> Self {
        return .init()
    }
}
