//
//  ReturnCodeResult.swift
//  TinderInterfaceDemo
//
//  Created by 石場清子 on 2020/02/10.
//  Copyright © 2020 石場清子. All rights reserved.
//

import UIKit

enum IndividualResult {
    case loading
    case success(T: Decodable)
    case failure(status: WebAPIReturnCode)
    case error(T: String)
}

protocol ReturnCodeResult: class {
    func returnCodeResult(returnCode: IndividualResult)
}
