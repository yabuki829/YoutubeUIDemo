//
//  PlayList.swift
//  YoutubeDemo
//
//  Created by Yabuki Shodai on 2022/04/29.
//

import Foundation


struct PlayList:Decodable {
    var kind = ""
    var etag = ""
    var items: [itemsofPlayList]
    var pageInfo:PageInfo
}


struct itemsofPlayList:Decodable{
    let snippet:snippetofPlayList
}

struct snippetofPlayList: Decodable{
    var publishedAt = ""
    var channelId = ""
    var title = ""
    var description = ""
    var thumbnails: Thumbnail
    var resourceId :Resource
    var videoOwnerChannelTitle = ""
}


struct Resource:Decodable {
    var videoId = ""
}


