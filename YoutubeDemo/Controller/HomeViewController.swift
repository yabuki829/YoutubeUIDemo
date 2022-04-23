//
//  ViewController.swift
//  YoutubeDemo
//
//  Created by Yabuki Shodai on 2022/04/17.
//

import UIKit
//
class HomeViewController: UICollectionViewController,UICollectionViewDelegateFlowLayout, reloadDelegate {
 
    
    
    var videos = [Video]()
    
    var scrollBeginPoint: CGFloat = 0.0
    
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
        fetchVideos()
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let colors:[UIColor] = [.red,.link,.green,.orange,.darkGray,.blue,.purple,.orange,.systemPink]
      
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! videoCell
        cell.backgroundColor = colors[menuBar.selectedIndexPath!.row]
        return cell
       
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (view.frame.width ) * 9 / 16
        return CGSize(width: view.frame.width , height: height  + 8 + 8  + 80  )
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
    
    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        scrollBeginPoint = scrollView.contentOffset.y
    }

    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollDiff = scrollBeginPoint - scrollView.contentOffset.y
        updateNavigationBarHiding(scrollDiff: scrollDiff)
    }
    func updateNavigationBarHiding(scrollDiff: CGFloat) {
         /// スクロール量の閾値
         // navigationBar表示
         if scrollDiff > 0 {
             navigationController?.setNavigationBarHidden(false, animated: true)
            UIView.animate(withDuration: 1.0) {
                self.menuBar.transform =   CGAffineTransform(translationX: 0, y: 0)
               
            }
             return
         }
         
         // navigationBar非表示
         if scrollDiff <= 0 {
             navigationController?.setNavigationBarHidden(true, animated: true)
            UIView.animate(withDuration: 1.0) {
                let statusBarHeight =  self.view.window?.windowScene?.statusBarManager?.statusBarFrame.height
                self.menuBar.transform =   CGAffineTransform(translationX: 0, y: -(statusBarHeight ?? 0))
            }
           
             return
         }
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("-------------------------------------")
        print(videos[indexPath.row].title!,videos[indexPath.row].id!)
        navigationController?.hidesBarsOnSwipe = false
    }
    private func setupMenuBar(){
        navigationController?.hidesBarsOnSwipe = true
        navigationController?.navigationBar.backgroundColor = .white
        menuBar.delegate = self
        view.addSubview(menuBar)
        addMenuBarConstraint()
    }
    func reload() {
        collectionView.reloadData()
        
        //ここでfetchVideo
        print(menuBarTitleArray[menuBar.selectedIndexPath!.row])
    }
    private func  setupMenuBarItems(){
        
        
        let searchImage = UIImage(systemName:"magnifyingglass") //tv  bell
       
        let searchItem = UIBarButtonItem(image: searchImage, style: .plain, target: self, action: #selector(search))

        let tvImage = UIImage(systemName: "tv")
        let tvItem = UIBarButtonItem(image: tvImage, style: .plain, target: self, action: #selector(tv))
        
        let bellImage = UIImage(systemName: "bell")
        let bellItem = UIBarButtonItem(image: bellImage, style: .plain, target: self, action: #selector(notifications))
        
        let accountImage = UIImage(systemName: "person.circle.fill")
       
        let accountItem = UIBarButtonItem(image: accountImage, style: .plain, target: self, action: #selector(tapUserIcon))
        accountItem.tintColor = .link
        navigationItem.rightBarButtonItems = [accountItem,searchItem,bellItem,tvItem]
        
        navigationController?.navigationBar.tintColor = .darkGray
        
        
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
        handleUserInfo()
    }
    func addMenuBarConstraint(){
       
        let guide = self.view.safeAreaLayoutGuide //これを入れたら表示されるようになった
        menuBar.translatesAutoresizingMaskIntoConstraints = false
        menuBar.topAnchor.constraint(equalTo: guide.topAnchor, constant: 0.0).isActive = true
        menuBar.leftAnchor.constraint(equalTo: guide.leftAnchor, constant: 0.0).isActive = true
        menuBar.rightAnchor.constraint(equalTo: guide.rightAnchor, constant: 0.0).isActive = true
        menuBar.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        
    }

    
    func handleUserInfo(){
        let layout = UICollectionViewFlowLayout()
        let nav = UINavigationController(rootViewController: UserProfileView(collectionViewLayout: layout))
        nav.modalPresentationStyle = .fullScreen
        self.present(nav, animated: true, completion: nil)
    }
    
    func fetchVideos(){
//        let url = URL(string:"https://www.googleapis.com/youtube/v3/search?key=AIzaSyB7h20I9c00-sdZh8OAYLtyZEVuklcq0EI&q=DetectiveConan&part=snippet&maxResults=10&order=date")
        let url = URL(string: "file:///Users/yabukishodai/youtubeDemo.json")
        var request = URLRequest(url: url!)
        
        request.httpMethod = "GET"
        
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
                        let channel = Channel(name:item.snippet.channelTitle , profileImage:item.snippet.thumbnails.high.url)
                        video.date = item.snippet.publishTime
                        video.thumbnailImage = item.snippet.thumbnails.high.url
                        video.channel = channel
                        
                        self.videos.append(video)
                    }
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
                    
                }catch(let error){
                        print("動画の取得に失敗しました:",error)
                    return
                }
        })
        task.resume()
    }
}

