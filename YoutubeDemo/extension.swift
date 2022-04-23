//
//  extension.swift
//  YoutubeDemo
//
//  Created by Yabuki Shodai on 2022/04/22.
//

import Foundation
import UIKit

let imageCache = NSCache<AnyObject, UIImage>()

extension UIImageView{

    func loadImageUsingUrlString(urlString:String){
        image = nil
        let url = URL(string: urlString)
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
            
        let task = URLSession.shared.dataTask(with: url!) {  (data, response, error) in
            if error != nil{
                return
            }
            DispatchQueue.main.async {
                self.image = UIImage(data: data!)
            }
          
        }
        task.resume()
    }
}
