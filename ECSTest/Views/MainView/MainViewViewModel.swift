//
//  MainViewViewModel.swift
//  ECSTest
//
//  Created by Tulasi on 03/08/19.
//  Copyright © 2019 Assignment. All rights reserved.
//

import Foundation
import UIKit

struct MainViewViewModel {
    var viewObj: ViewObj?
    
    func titleText() -> String{
        return viewObj?.title ?? ""
    }
    func byText() -> NSAttributedString {
        let main_string = (viewObj?.byline ?? "") +  "              ."
        let string_to_color = "              ."
        
        let range = (main_string as NSString).range(of: string_to_color)
        
        let attribute = NSMutableAttributedString.init(string: main_string)
        attribute.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.clear , range: range)

        return attribute
 
    }
    func dateText() -> String {
        return "\u{1F4C5} " +  (viewObj?.published_date ?? "")
    }
    func imgURL() -> String {
        if let media = viewObj?.media?.first?.media_metadata?.first {
            return media.url ?? ""
        }
        return ""
    }
    func detailURL() -> String {
        
        return viewObj?.url ?? ""
    }
}
