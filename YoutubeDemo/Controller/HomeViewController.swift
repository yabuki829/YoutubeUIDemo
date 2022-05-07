import UIKit
class HomeViewController: UICollectionViewController,UICollectionViewDelegateFlowLayout,moveDelegate {

    
    let indicator:UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.style = .large
        indicator.color = UIColor(red: 44/255, green: 169/255, blue: 225/255, alpha: 1)
        indicator.backgroundColor = .darkGray
        return indicator
    }()
    
    var scrollBeginPoint: CGFloat = 0.0
    var videos = [Video]()
    var cvtopConstraint:NSLayoutConstraint?
    fileprivate let refreshCtl = UIRefreshControl()
    let menuBar:MenuBar = {
        let menubar = MenuBar()
        return menubar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .systemGray6
        collectionView.register(videoCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.register(videoRecomment.self, forCellWithReuseIdentifier: "recomemnt")
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 80, right: 0)
        collectionView.refreshControl = refreshCtl
        refreshCtl.addTarget(self, action: #selector(refresh(sender:)), for: .valueChanged)
        
        collectionView.delegate = self
        indicator.center = view.center
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        titleLabel.font = UIFont(name: "AlNile-Bold", size: 20)
        titleLabel.text = "MusicTube"
        navigationItem.titleView = titleLabel
        navigationController?.navigationBar.barTintColor = UIColor.white
       
        
        setupMenuBarItems()
       
    }
    override func viewDidAppear(_ animated: Bool) {
        fetchVideos(word: "")
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videos.count + 1
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        if indexPath.row == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "recomemnt", for: indexPath) as! videoRecomment
            cell.delegate = self
            
            return cell
        }
        else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! videoCell
            cell.video = Video()
            cell.video = videos[indexPath.row - 1]
            return cell
        }
      
       
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.row == 0{
            return CGSize(width: view.frame.width, height: view.frame.height / 8 + 100 )
        }
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
         // MenuBar表示
         if scrollDiff > 0 {
             navigationController?.setNavigationBarHidden(false, animated: true)
            UIView.animate(withDuration: 1.0) {
                self.menuBar.transform =   CGAffineTransform(translationX: 0, y: 0)
               
            }
             return
         }
         
         // MenuBar非表示
         if scrollDiff <= 0 {
             navigationController?.setNavigationBarHidden(true, animated: true)
            UIView.animate(withDuration: 1.0) {
                let statusBarHeight =  self.view.window?.windowScene?.statusBarManager?.statusBarFrame.height
                self.menuBar.transform =   CGAffineTransform(translationX: 0, y: -(statusBarHeight ?? 0))
            }
           
             return
         }
    }
 
    let videoLancher = VideoLancher()
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0{
            
        }
        else{
            
            videoLancher.showSetting(videoID: videos[indexPath.row - 1].id!, videoTitle: videos[indexPath.row - 1].title!)
            videoLancher.titleLabel.isHidden = true
            videoLancher.backButton.isHidden = true
        }
        
    }
    @objc func refresh(sender: UIRefreshControl) {
        refreshCtl.endRefreshing()
         //再度動画をよみこむ
        
      
    }
    private func  setupMenuBarItems(){
        let searchImage = UIImage(systemName:"magnifyingglass")
        let searchItem = UIBarButtonItem(image: searchImage, style: .plain, target: self, action: #selector(search))
        
        
        let accountImage = UIImage(systemName: "gearshape")
       
        let accountItem = UIBarButtonItem(image: accountImage, style: .plain, target: self, action: #selector(tapSettingIcon))
        
        navigationItem.rightBarButtonItems = [accountItem,searchItem]
        
        navigationController?.navigationBar.tintColor = .darkGray
        
        
    }
    
    @objc  func search(){
        let layout = UICollectionViewFlowLayout()
        let nav = UINavigationController(rootViewController: SearchViewController(collectionViewLayout: layout))
        nav.modalPresentationStyle = .fullScreen
        self.present(nav, animated: true, completion: nil)
        
    }
    @objc func tapSettingIcon(){
        print("tapUserIcon")
        handleUserInfo()
    }

    
    func handleUserInfo(){
        let layout = UICollectionViewFlowLayout()
        let nav = UINavigationController(rootViewController: UserSettingView(collectionViewLayout: layout))
        nav.modalPresentationStyle = .fullScreen
        self.present(nav, animated: true, completion: nil)
    }
    
    func fetchVideos(word:String){
        indicator.startAnimating()
        print("インゲーター")
        //急上昇を取得する
        ApiManager.shere.fetchSourVideo(before:todayFormat() , after: beforeFormat()) { (videodata) in
            // インジケーターを非表示＆アニメーション終了
            print("終了")
            self.indicator.stopAnimating()
            self.videos = videodata
            self.collectionView.reloadData()
            self.scrollTop()
        }
    }
    func scrollTop(){
        let indexPath = IndexPath(row: 0, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .top, animated: true)
    }
    func move(playList: [Video], titleText: String) {
        
        let layout = UICollectionViewFlowLayout()
        let vc = PlayListViewController(collectionViewLayout: layout)
        vc.playList = playList
        vc.navigationItem.title = titleText
        let nav = UINavigationController(rootViewController: vc)
        self.present(nav, animated: true, completion: nil)
    }
    func beforeFormat() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let modifiedDate = Calendar.current.date(byAdding: .day, value: -21, to: Date())!
        let formatter = ISO8601DateFormatter()
        let str = formatter.string(from:modifiedDate)
        print(str)
        return str
    }
    func todayFormat() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let formatter = ISO8601DateFormatter()
        let str = formatter.string(from:Date())
        print(str)
        return str
    }
}

