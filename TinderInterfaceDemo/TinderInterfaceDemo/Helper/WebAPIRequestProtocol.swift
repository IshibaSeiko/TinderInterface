//
//  WebAPIRequestProtocol.swift
//  TinderInterfaceDemo
//
//  Created by 石場清子 on 2020/02/10.
//  Copyright © 2020 石場清子. All rights reserved.
//


import Alamofire

protocol WebAPIRequestProtocol: class {
    var baseURLString: String { get }
    var httpMethod: HTTPMethod { get }
    var path: String { get }
    var headers: [String: String] { get }
    var bodys: [String: Any] { get }
    var parameters: [String: String] { get }
}

extension WebAPIRequestProtocol {

    var baseURLString: String {
        return ""
    }

    var endPoint: String {
        return ""
    }

    var httpMethod: HTTPMethod {
        return .post
    }

    var path: String {
        return ""
    }

    var headers: [String: String] {
        return [
            "Content-Type": "application/json"
        ]
    }

    var bodys: [String: Any] {
        return [:]
    }

    var parameters: [String: String] {
        return [:]
    }
}
