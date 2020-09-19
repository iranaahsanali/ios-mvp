//
//  ViewControllerExtensions.swift
//  ios-mvp
//
//  Created by Ahsan Ali on 15/06/2020.
//  Copyright © 2020 Ahsan Ali. All rights reserved.
//

import UIKit

extension UIViewController {
    
    // MARK: Activity Indicators
    func showProgress() {
        let activityView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        activityView.tag = 323494
        activityView.center = self.view.center
        self.view.addSubview(activityView)
        activityView.startAnimating()
    }
    
    func hideProgress() {
        let activityView = self.view.viewWithTag(323494)
        activityView?.removeFromSuperview()
    }
    
    // MARK: - Error Handling
    func handleError(error : Error)
    {
        self.hideProgress()
        showAlert(title: Constants.AppName, message: error.localizedDescription)
    }
    
    // MARK: Alert Methods
    func showAlert(title:String, message:String) {
        showAlert(title: title, message: message) { }
    }
    
    func showAlert(title:String, message:String, handler: @escaping () -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            handler()
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
