//
//  ViewController+Initialize.swift
//  TinderInterfaceDemo
//
//  Created by 石場清子 on 2020/02/10.
//  Copyright © 2020 石場清子. All rights reserved.
//

import UIKit

public extension UIStoryboard {

    class func viewController<T: UIViewController>(storyboardName: String,
                                                   identifier: String) -> T? {

        return UIStoryboard(name: storyboardName, bundle: nil).instantiateViewController(
            withIdentifier: identifier) as? T
    }
}
