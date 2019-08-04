//
//  ViewControllerExtension.swift
//  ECSTest
//
//  Created by Tulasi on 04/08/19.
//  Copyright © 2019 Assignment. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    //Show loader
    func showLoader() {
        let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
    
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.gray
        loadingIndicator.startAnimating();
        
        alert.view.addSubview(loadingIndicator)
        self.present(alert, animated: true, completion: nil)
    }
    //Hide loader
    func dismissLoader() {
        self.dismiss(animated: false, completion: nil)
    }
   
}
