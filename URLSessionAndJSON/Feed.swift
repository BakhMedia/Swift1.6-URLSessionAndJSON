//
//  Feed.swift
//  URLSessionAndJSON
//
//  Created by Ilya Aleshin on 26.07.2018.
//  Copyright © 2018 Bakh. All rights reserved.
//
class Feed {
    
    public var cover: String
    public var link: String
    public var title: String
    
    init(data d: [String:Any]) {
        self.cover = d["cover"] as! String
        self.link = d["link"] as! String
        self.title = d["title"] as! String
    }
    
}
