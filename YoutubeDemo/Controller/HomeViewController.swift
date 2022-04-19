//
//  ViewController.swift
//  YoutubeDemo
//
//  Created by Yabuki Shodai on 2022/04/17.
//

import UIKit


//
class HomeViewController: UICollectionViewController,UICollectionViewDelegateFlowLayout {
    
    var videos:[Video] = {
        
        var channel = Channel()
        channel.name = "HikakinTV HikakinTV HikakinTV HikakinTV HikakinTV "
        channel.profileImage = "hikakinprofile"
        
        var video = Video()
        video.title = "好きなことで、生きていく - HIKAKIN - Youtube"
        video.topImageName = "hikakin"
        video.numberofViews = 123456789
        video.channel = channel
        
        var video2 = Video()
        video2.title = "YouTubeテーマソング/ヒカキン＆セイキンYouTubeテーマソング/ヒカキン＆セイキンYouTubeテーマソング/ヒカキン＆セイキンYouTubeテーマソング/ヒカキン＆セイキンYouTubeテーマソング/ヒカキン＆セイキンYouTubeテーマソング/ヒカキン＆セイキン"
        video2.topImageName = "hikakinte-masong"
        video2.numberofViews = 2345678901234
        video2.channel = channel
        
        
        
        return [video,video2,video]
    }()
    
    
    let menuBar:MenuBar = {
        let menubar = MenuBar()
        return menubar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        collectionView.register(videoCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.contentInset = UIEdgeInsets(top: 40, left: 0, bottom: 0, right: 0)
        collectionView.scrollIndicatorInsets = UIEdgeInsets(top: 40, left: 0, bottom: 0, right: 0)
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        titleLabel.font = UIFont(name: "AlNile-Bold", size: 20)
        titleLabel.text = "YouTube"
        navigationItem.titleView = titleLabel
        navigationController?.navigationBar.barTintColor = UIColor.white
        
        setupMenuBar()
        setupMenuBarItems()
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videos.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! videoCell
        cell.video = videos[indexPath.row]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (view.frame.width ) * 9 / 16
        return CGSize(width: view.frame.width , height: height  + 8 + 8  + 80  )
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    
    private func setupMenuBar(){
        view.addSubview(menuBar)
        addMenuBarConstraint()
    }
    private func  setupMenuBarItems(){
        let searchImage = UIImage(systemName:"magnifyingglass") //tv  bell
        let searchItem = UIBarButtonItem(image: searchImage, style: .plain, target: self, action: #selector(search))
        
        let tvImage = UIImage(systemName: "tv")
        let tvItem = UIBarButtonItem(image: tvImage, style: .plain, target: self, action: #selector(tv))
        
        let bellImage = UIImage(systemName: "bell")

        let bellItem = UIBarButtonItem(image: bellImage, style: .plain, target: self, action: #selector(notifications))
        navigationItem.rightBarButtonItems = [searchItem,bellItem,tvItem]
        
        navigationController?.navigationBar.tintColor = .darkGray
        
        navigationItem.leftBarButtonItem = searchItem
        
    }
    
    @objc  func search(){
        print("Search")
    }
    @objc func tv(){
        print("TV")
    }
    @objc func notifications(){
        print("Notification")
    }
    @objc func tapUserIcon(){
        print("tapUserIcon")
    }
    func addMenuBarConstraint(){
       
        let guide = self.view.safeAreaLayoutGuide //これを入れたら表示されるようになった
        menuBar.translatesAutoresizingMaskIntoConstraints = false
        menuBar.topAnchor.constraint(equalTo: guide.topAnchor, constant: 0.0).isActive = true
        menuBar.leftAnchor.constraint(equalTo: guide.leftAnchor, constant: 0.0).isActive = true
        menuBar.rightAnchor.constraint(equalTo: guide.rightAnchor, constant: 0.0).isActive = true
        menuBar.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
    }
   
        
     
}



