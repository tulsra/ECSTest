//
//  ImageExtension.swift
//  ECSTest
//
//  Created by Tulasi on 03/08/19.
//  Copyright © 2019 Assignment. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    //Download image from server
    public func imageFromServerURL(urlString: String) {
        self.image = nil
        URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in
            
            if error != nil {
                print(error)
                return
            }
            DispatchQueue.main.async(execute: { () -> Void in
                let image = UIImage(data: data!)
                self.image = image
            })
            
        }).resume()
    }
    
}

