//
//  String+localize.swift
//  TinderInterfaceDemo
//
//  Created by 石場清子 on 2020/02/10.
//  Copyright © 2020 石場清子. All rights reserved.
//

import Foundation

extension String {

    func localized() -> String {
        return NSLocalizedString(self, comment: "")
    }

    func localized(value: String) -> String {
        return String(format: NSLocalizedString(self, comment: ""), value)
    }
}
