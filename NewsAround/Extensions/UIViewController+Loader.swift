//
//  UIViewController+Loader.swift
//  NewsAround
//
//  Created by Sanjeeva Reddy Nandela on 8/6/22.
//

import UIKit

extension UIViewController {
    
    func showLoader(flag: Bool, title: String? = "Please wait...") {
        if flag {
            let alert = UIAlertController(title: nil, message: title, preferredStyle: .alert)
            let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
            loadingIndicator.hidesWhenStopped = true
            loadingIndicator.style = UIActivityIndicatorView.Style.medium
            loadingIndicator.startAnimating()
            alert.view.addSubview(loadingIndicator)
            present(alert, animated: true, completion: nil)
        }else {
            if var topController:UIViewController = UIApplication.shared.keyWindow?.rootViewController {
                while ((topController.presentedViewController) != nil) {
                    topController = topController.presentedViewController!
                }
                topController.dismiss(animated: true)
            }
        }
    }
    
}
