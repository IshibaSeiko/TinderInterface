//
//  APIClient.swift
//  TinderInterfaceDemo
//
//  Created by 石場清子 on 2020/02/10.
//  Copyright © 2020 石場清子. All rights reserved.
//

import UIKit
import Alamofire
import Reachability

enum Result<T> {
    case success(T)
    case failure(Error)
    case forbiddenError
}

enum StatusCode: Int {
    case success = 200
    case forbidden = 403
    case notFound = 404
}

enum FetchError: Error {
    case missingData   // データがないとき
}

class APIClient {

    /// タイムインターバル
    static let defaultTimeInterval: TimeInterval = 30

    /// 端末の通信状態を取得
    ///
    /// - Returns: true: オンライン, false: オフライン
    static func isReachable() -> Bool {

        if let reachabilityManager = NetworkReachabilityManager() {
            reachabilityManager.startListening()
            return reachabilityManager.isReachable
        }
        return false
    }

    static func request<T: WebAPIRequestProtocol>(request: T,
    completionHandler: @escaping (Result<Data?>) -> Void = { _ in }) {

        guard let url =  URL(string: request.baseURLString + request.path) else {
            fatalError("URLが不正")
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.httpMethod.rawValue
        urlRequest.allHTTPHeaderFields = request.headers
        urlRequest.timeoutInterval = defaultTimeInterval
        urlRequest.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData

        if !request.bodys.isEmpty {

            do {
                let jsonData = try JSONSerialization.data(withJSONObject: request.bodys, options: [])
                let jsonString = String(data: jsonData, encoding: .utf8) ?? "no body data"
                urlRequest.httpBody = jsonString.data(using: .utf8)
            } catch {
                log?.error(error.localizedDescription)
            }
        }
        
        Alamofire.request(urlRequest).responseJSON { response in

            if let body = response.request?.httpBody, let bodyJson = String(data: body, encoding: .utf8) {
                log?.info("\n👆👆👆\nRequestURL:\(request.baseURLString + request.path)" +
                    "\nRequestHeader: \(request.headers.prettyPrintedJsonString))" +
                    "\nReqeustBody : \(bodyJson)" +
                    "\nRequestParameter: \(request.parameters.prettyPrintedJsonString)")
            } else {
                log?.info("\n👆👆👆\nRequestURL:\(request.baseURLString + request.path)" +
                    "\nRequestHeader: \(request.headers.prettyPrintedJsonString))" +
                    "\nRequestParameter: \(request.parameters.prettyPrintedJsonString)")
            }
            guard let statusCode = response.response?.statusCode else {
                if let error = response.error {
                    completionHandler(Result.failure(error))
                }
                return
            }

            if case .forbidden? = StatusCode(rawValue: statusCode) {
                completionHandler(Result.forbiddenError)
                return
            }

            var responseJson = ""
            if let json = response.value as? [String: Any] {
                responseJson = json.prettyPrintedJsonString
            } else {

                if let jsonArray = response.value as? [[String: Any]] {

                    for json in jsonArray {
                        responseJson += json.prettyPrintedJsonString
                    }
                }
            }
            switch response.result {

            case .success:
                log?.info("\n👇👇👇" +
                    "\nStatusCode: \(statusCode)\nResponseBody: \(responseJson)")
                completionHandler(Result.success(response.data))
                return

            case .failure:
                log?.error("\n🔻🔻🔻" +
                    "\nStatusCode: \(statusCode)\nResponseBody: \(responseJson)")

                if let error = response.error {
                    completionHandler(Result.failure(error))
                    return
                }
            }
        }
    }
}
