//
//  ChannelViewContriller.swift
//  YoutubeDemo
//
//  Created by Yabuki Shodai on 2022/04/22.
//

import Foundation
import UIKit

class ChannelViewController:UICollectionViewController,UICollectionViewDelegateFlowLayout{

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
      
        
       
        setupMenuBarItems()
    }
   
    private func  setupMenuBarItems(){
        
       
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 64, height: view.frame.height))
        titleLabel.font = UIFont(name: "AlNile-Bold", size: 16)
        titleLabel.text = "チャンネル名"
        navigationItem.titleView = titleLabel
        
        let searchImage = UIImage(systemName:"magnifyingglass")
        let searchItem = UIBarButtonItem(image: searchImage, style: .plain, target: self, action: #selector(search))

        let tvImage = UIImage(systemName: "tv")
        let tvItem = UIBarButtonItem(image: tvImage, style: .plain, target: self, action: #selector(tv))
        
        let settingImage = UIImage(systemName: "ellipsis")
        let settingItem = UIBarButtonItem(image: settingImage, style: .plain, target: self, action: #selector(setting))
        
        
        navigationItem.rightBarButtonItems = [settingItem,searchItem,tvItem]
        
        navigationController?.navigationBar.tintColor = .darkGray
        
        let accountImage = UIImage(systemName: "chevron.left")
        let accountItem = UIBarButtonItem(image: accountImage, style: .plain, target: self, action: #selector(back(sender:)))
        accountItem.tintColor = .darkGray
        navigationItem.leftBarButtonItems = [accountItem]
        
    }
    
    
   
    @objc  func search(){
        print("Search")
    }
    @objc func tv(){
        print("TV")
    }
    let settingLancher = SettingLancher()
    
    @objc func setting(){
        print("Setting")
        settingLancher.showSetting()
    }
    
    @objc func back(sender : UIButton){
        self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    
}
