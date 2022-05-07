//
//  Api.swift
//  YoutubeDemo
//
//  Created by Yabuki Shodai on 2022/04/24.
//

import Foundation


class ApiManager{
    
    static let shere = ApiManager()
    let apikey = ""
//    let apikey = ""//テスト用
    
    func fetchVideos(word:String,compleation:@escaping ([Video]) -> Void){
        let encodeString:String = word.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)!
//        let url = URL(string: "file:///Users/yabukishodai/Dropbox/YoutubeApi/youtubeApi.json")
        
        let url = URL(string:"https://www.googleapis.com/youtube/v3/search?key=\(apikey)&q=\(encodeString)&part=snippet&maxResults=10&order=viewCount")
//        https://www.googleapis.com/youtube/v3/search?part=snippet&relatedToVideoId=\(videoID)&type=video&key=\(apikey)
        
        var request = URLRequest(url: url!)
        
        request.httpMethod = "GET"
        var videos = [Video]()
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url!), completionHandler: { (data, response, error) in
            if error != nil{
                    return
                }
                do {
            
                    let results = try JSONDecoder().decode(Result.self, from: data!)
                  
                    for item in results.items{
                       
                        var video = Video()
                        video.id = item.id?.videoId
                        video.title = item.snippet.title
                        let channel = Channel(name:item.snippet.channelTitle)
                        video.date = item.snippet.publishTime
                        video.thumbnailImage = item.snippet.thumbnails.high.url
                        video.channel = channel
                        
                        videos.append(video)
                       
                    }
                    DispatchQueue.main.async {
                        compleation(videos)
                    }
                }catch(let error){
                        print("動画の取得に失敗しました:",error)
                    return
                }
        })
        task.resume()
    }
    func searchVideo(word:String,compleation:@escaping ([Video]) -> Void){
        let url = URL(string:"https://www.googleapis.com/youtube/v3/search?key=\(apikey)&q=\(word)&part=snippet&maxResults=10&order=viewCount")
        var request = URLRequest(url: url!)
        
        request.httpMethod = "GET"
        var videos = [Video]()
        print("取得します")
        let task = URLSession.shared.dataTask(with: URLRequest(url: url!), completionHandler: { (data, response, error) in
            if error != nil{
                print("エラー")
                    return
                }
                do {
                    print("取得中")
                    let results = try JSONDecoder().decode(Result.self, from: data!)
                    
                  print("デコード完了")
                    for item in results.items{
                       
                        var video = Video()
                        video.id = item.id?.videoId
                        video.title = item.snippet.title
                        var channel = Channel(name:item.snippet.channelTitle)
                        channel.url = item.snippet.channelId
                        video.date = item.snippet.publishTime
                        video.thumbnailImage = item.snippet.thumbnails.high.url
                        video.description = item.snippet.description
                        video.channel = channel
                        videos.append(video)
                        
                       
                    }
                    DispatchQueue.main.async {
                        print("取得完了")
                        compleation(videos)
                    }
                }
                catch(let error){
                        print("関連動画の取得に失敗しました:",error)
                    return
                }
        })
        task.resume()
    }
    
    func fetchPlayList(playListID:String,compleation:@escaping ([Video]) -> Void){
         let url = URL(string: "https://www.googleapis.com/youtube/v3/playlistItems?part=snippet&maxResults=20&playlistId=\(playListID)&key=\(apikey)")
//        let url = URL(string: "https://www.googleapis.com/youtube/v3/playlistItems?part=snippet&playlistId=\(playListID)&key=\(apikey)")
//        let url = URL(string: "file:///Users/yabukishodai/Dropbox/YoutubeApi/ChannelList/playListApi.json")
        var request = URLRequest(url: url!)
        
        request.httpMethod = "GET"
        var videos = [Video]()
        print("取得します")
        let task = URLSession.shared.dataTask(with: URLRequest(url: url!), completionHandler: { (data, response, error) in
            if error != nil{
                print("エラー")
                    return
                }
                do {
                    print("取得中")
                    let results = try JSONDecoder().decode(PlayList.self, from: data!)
                  print("デコード完了")
                    for item in results.items{
                       
                        var video = Video()
                        video.id = item.snippet.resourceId.videoId
                        video.title = item.snippet.title
                        var channel = Channel(name:item.snippet.videoOwnerChannelTitle)
                        channel.url = item.snippet.channelId
                        video.date = item.snippet.publishedAt
                        video.thumbnailImage = item.snippet.thumbnails.high.url
                        video.description = item.snippet.description
                        video.channel = channel
                        videos.append(video)
                        
                    }
                    
                    DispatchQueue.main.async {
                        print("取得完了")
                        compleation(videos)
                    }
                }catch(let error){
                        print("動画の取得に失敗しました:",error)
                    return
                }
        })
        task.resume()
    }
   
   
    func fetchRelatedVideos(videoID:String,compleation:@escaping ([Video]) -> Void){
        let url = URL(string: "https://www.googleapis.com/youtube/v3/search?part=snippet&relatedToVideoId=\(videoID)&type=video&key=\(apikey)&maxResults=3")
        var request = URLRequest(url: url!)
        
        request.httpMethod = "GET"
        var videos = [Video]()
        print("取得します")
        let task = URLSession.shared.dataTask(with: URLRequest(url: url!), completionHandler: { (data, response, error) in
            if error != nil{
                print("エラー")
                    return
                }
              
            do {
                let results = try JSONDecoder().decode(Related.self, from: data!)
              print("デコード完了")
                print(results.items.count)
                for item in results.items{
                 
                    var video = Video()
                    if let id = item!.id.videoId,
                       let title = item?.snippet?.title,
                       let date = item?.snippet?.publishedAt,
                       let thumbnailImage = item?.snippet?.thumbnails.high.url,
                       let channelTitle = item?.snippet?.channelTitle,
                       let channelID = item?.snippet?.channelId{
                        video.id = id
                        video.title = title
                        video.date = date
                        video.thumbnailImage = thumbnailImage
                        video.description = item?.snippet?.description
                        video.channel = Channel(name: channelTitle,url: channelID)
                        
                        videos.append(video)
                    }
                   
                   
                    
                    

                }
                DispatchQueue.main.async {
                    print("取得完了")
                    print("videoの数",videos.count)
                    compleation(videos)
                }
            }catch(let error){
                    print("動画の取得に失敗しました:",error)
                return
            }
                   
               
        })
        task.resume()
    }
    
    func fetchSourVideo(before:String,after:String,compleation:@escaping ([Video]) -> Void){
        let url = URL(string:"https://www.googleapis.com/youtube/v3/search?key=\(apikey)&part=snippet&type=video&order=viewCount&publishedAfter=\(after)&publishedBefore=\(before)&regionCode=JP&maxResults=10")
//        let url = URL(string: "file:///Users/yabukishodai/Dropbox/YoutubeApi/youtubeApi.json")
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        var videos = [Video]()
        print("取得します")
        let task = URLSession.shared.dataTask(with: URLRequest(url: url!), completionHandler: { (data, response, error) in
            if error != nil{
                print("エラー")
                    return
                }
                do {
                    let results = try JSONDecoder().decode(Result.self, from: data!)
                  print("デコード完了")
                    for item in results.items{
                       
                        var video = Video()
                        video.id = item.id?.videoId
                        video.title = item.snippet.title
                        let channel = Channel(name:item.snippet.channelTitle )
                        video.date = item.snippet.publishTime
                        video.thumbnailImage = item.snippet.thumbnails.high.url
                        video.description = item.snippet.description
                        video.channel = channel
                        videos.append(video)
                        
                    }
                    
                    
                    DispatchQueue.main.async {
                        print("取得完了")
                        compleation(videos)
                    }
                }catch(let error){
                        print("動画の取得に失敗しました:",error)
                    return
                }
        })
        task.resume()
    }
}


//Error acquiring assertion: <Error Domain=RBSServiceErrorDomain Code=1 "(originator doesn't have entitlement com.apple.runningboard.assertions.webkit AND originator doesn't have entitlement com.apple.multitasking.systemappassertions)" UserInfo={NSLocalizedFailureReason=(originator doesn't have entitlement com.apple.runningboard.assertions.webkit AND originator doesn't have entitlement com.apple.multitasking.systemappassertions)}>
//2022-05-04 16:45:28.796981+0900 YoutubeDemo[20245:5793891] [ProcessSuspension] 0x10adbc000 - ProcessAssertion: Failed to acquire RBS assertion 'WebKit Media Playback' for process with PID=20250, error: Error Domain=RBSServiceErrorDomain Code=1 "(originator doesn't have entitlement com.apple.runningboard.assertions.webkit AND originator doesn't have entitlement com.apple.multitasking.systemappassertions)" UserInfo={NSLocalizedFailureReason=(originator doesn't have entitlement com.apple.runningboard.assertions.webkit AND originator doesn't have entitlement com.apple.multitasking.systemappassertions)}



//2022-05-04 16:46:13.116633+0900 YoutubeDemo[20245:5794254] [connection] nw_read_request_report [C4] Receive failed with error "Socket is not connected"
//2022-05-04 16:46:13.124131+0900 YoutubeDemo[20245:5794254] [connection] nw_read_request_report [C4] Receive failed with error "Socket is not connected"
//2022-05-04 16:46:13.125125+0900 YoutubeDemo[20245:5794254] [connection] nw_read_request_report [C4] Receive failed with error "Socket is not connected"
//2022-05-04 16:46:13.130174+0900 YoutubeDemo[20245:5794254] [connection] nw_read_request_report [C1] Receive failed with error "Software caused connection abort"
//2022-05-04 16:46:13.141981+0900 YoutubeDemo[20245:5794254] [quic] quic_send_frames_for_key_state_block_invoke [C4.1.1:2] [-6a6a8164ee8371e6] unable to request outbound data
//error in connection_block_invoke_2: Connection interrupted
////
