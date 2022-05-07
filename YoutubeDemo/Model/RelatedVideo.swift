//
//  RelatedVideo.swift
//  YoutubeDemo
//
//  Created by Yabuki Shodai on 2022/04/30.
//

import Foundation
import UIKit

struct Related:Decodable {
    var items: [itemsOfRelated?]
}

struct itemsOfRelated:Decodable{
    var id :Id
    var snippet :snippetOfRelated?
}

struct snippetOfRelated:Decodable{
    var publishedAt:String
    var channelId:String
    var title:String
    var description:String
    var thumbnails:Thumbnail
    var channelTitle:String
}
