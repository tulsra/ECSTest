//
//  ViewsApiResponse.swift
//  ECSTest
//
//  Created by Tulasi on 03/08/19.
//  Copyright © 2019 Assignment. All rights reserved.
//

import Foundation

class ViewsAPIResponse: NSObject, Mappable, Codable {
    
    var status: String?
    var copyright: String?
    var num_results: Int?
    var results: [ViewObj]?
    
    override init() {
        super.init()
    }
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        
        status <- map["status"]
        copyright <- map["copyright"]
        num_results <- map["num_results"]
        results <- map["results"]
    }
}

class ViewObj: NSObject, Mappable, Codable {

    var title:String?
    var abstract:String?
    var published_date:String?
    var byline:String?
    var url:String?
    var media:[MediaObj]?
    
    override init() {
        super.init()
    }
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
   
        title <- map["title"]
        abstract <- map["abstract"]
        published_date <- map["published_date"]
        byline <- map["byline"]
        url <- map["url"]
        media <- map["media"]
    }
    
}
class MediaObj: NSObject, Mappable, Codable {
    
    var type:String?
    var media_metadata:[MetadataObj]?
    
    override init() {
        super.init()
    }
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        
        type <- map["type"]
        media_metadata <- map["media-metadata"]
    }
    
}

class MetadataObj: NSObject, Mappable, Codable {
    
    var url:String?
    var format:String?
    
    override init() {
        super.init()
    }
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        
        url <- map["url"]
        format <- map["format"]
    }
    
}
