//
//  Video.swift
//  YoutubeDemo
//
//  Created by Yabuki Shodai on 2022/04/19.
//

import UIKit



struct Video{
    var id:String?
    var thumbnailImage:String?
    var title:String?
    var numberofViews:Int?
    var date:String?
    var channel: Channel?
}


struct Channel {
    var name: String?
    var profileImage: String?
}



struct PageInfo: Decodable {
    var totalResults = 0
    var resultsPerPage = 0
}


struct Snippet: Decodable {
    var channelId = ""
    var title = ""
    var description = ""
    var channelTitle = ""
    var publishTime = ""
    var thumbnails: Thumbnail
}

struct Thumbnail: Decodable {
    var high: ChannelURL
}

struct ChannelURL: Decodable {
    var url:String
}



struct Item: Decodable {
    var id: Id?
    var snippet: Snippet
   

}
struct Id:Decodable {
    var videoId:String?
}


struct Result: Decodable {
    var kind = ""
    var etag = ""
    var pageInfo: PageInfo
    var items: [Item]
}
