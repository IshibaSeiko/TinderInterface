//
//  Dictionary+JSON.swift
//  TinderInterfaceDemo
//
//  Created by 石場清子 on 2020/02/10.
//  Copyright © 2020 石場清子. All rights reserved.
//

import UIKit

extension Dictionary {

    var prettyPrintedJsonString: String {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: self, options: [.prettyPrinted])
            return String(bytes: jsonData, encoding: .utf8) ?? "JSON Covert Failre."
        } catch {
            return "JSON Covert Failre."
        }
    }
}
