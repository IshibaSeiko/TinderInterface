//
//  WebAPIReturnCode.swift
//  TinderInterfaceDemo
//
//  Created by 石場清子 on 2020/02/10.
//  Copyright © 2020 石場清子. All rights reserved.
//

import UIKit

//MARK: - Protocol
protocol GetAPIServiceDelegate: class {
    // MARK: required
    func error(status: WebAPIReturnCode)
}

extension GetAPIServiceDelegate {
    // MARK: Optional
}

//TODO: エラーコードを列挙
enum WebAPIReturnCode: String {
    /// 通信失敗(オフライン、タイムアウト)
    case connectionFailure = "connectionFailure"
    /// キャンセル
    case cancel = "cancel"
    case other = "other"

    var message: String {
        switch self {
        case .connectionFailure:
            return "通信失敗"
        case .cancel:
            return "cancel"
        case .other:
            return "サーバーの内部エラーが発生しています。"
        }
    }

    func showAlertDialogOK(_ viewController: UIViewController,
                           okHandler: ((UIAlertAction) -> Void)? = nil) {

        showAlertDialogOKAndCancel(viewController, okHandler: okHandler)
    }

    func showAlertDialogOKAndCancel(_ viewController: UIViewController,
                                    okHandler: ((UIAlertAction) -> Void)? = nil,
                                    cancelHandler: ((UIAlertAction) -> Void)? = nil) {

        let alert = UIAlertController(title: nil,
                                      message: message,
                                      preferredStyle: .alert)

        let okButton = UIAlertAction(title: "ALERT_OK".localized(),
                                     style: .default,
                                     handler: okHandler)

        alert.addAction(okButton)

        if let cancelHandler = cancelHandler {
            let cancelButton = UIAlertAction(title: "ALERT_CANCEL".localized(),
                                             style: .cancel,
                                             handler: cancelHandler)

            alert.addAction(cancelButton)
        }
        viewController.present(alert, animated: true, completion: nil)
    }
}
