
import Foundation
import UIKit
import WebKit
import AVFoundation

class VideoViewController: UICollectionViewController,UICollectionViewDelegateFlowLayout, WKUIDelegate{
    var videoID = ""
    var youtubetitle = ""
    var videos = [Video]()
    var webView:WKWebView = {
        let webConfiguration = WKWebViewConfiguration()
        webConfiguration.allowsInlineMediaPlayback = true
        webConfiguration.mediaTypesRequiringUserActionForPlayback = .all
        let wv = WKWebView(frame: .zero, configuration: webConfiguration)
        return wv
    }()
    
    let indicator:UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.style = .large
        indicator.color = UIColor(red: 44/255, green: 169/255, blue: 225/255, alpha: 1)
        indicator.backgroundColor = .darkGray
        return indicator
    }()

    override func viewDidLoad() {
        
        view.backgroundColor = .white
        navigationController?.navigationBar.backgroundColor = .white
        navigationItem.title = youtubetitle
        let top = view.frame.width * 9 / 16
        collectionView.register(videoCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.contentInset = UIEdgeInsets(top: top, left: 0, bottom: 30, right: 0)
        collectionView.scrollIndicatorInsets = UIEdgeInsets(top: top, left: 0, bottom: 0, right: 0)
        collectionView.backgroundColor = .white
        webView.uiDelegate = self
        
        view.addSubview(collectionView)
        view.addSubview(webView)
        view.addSubview(indicator)
        indicator.center = view.center
        addCollectionViewConstraint()
        addVideoConstraint()
        showVideo2(videoID: videoID)
        fetchRelated(videoID: videoID)
    }
   
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videos.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! videoCell
        cell.video = Video()
        cell.video = videos[indexPath.row]
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let heigth = view.frame.width * 9 / 16
        return CGSize(width: view.frame.width, height:  heigth  + 8 + 8  + 80 )
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        showVideo(videoID:videos[indexPath.row].id!)
        navigationItem.title = videos[indexPath.row].title!
        
    }
    func addCollectionViewConstraint(){
        collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
    }
    func addVideoConstraint(){
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        webView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        webView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        webView.heightAnchor.constraint(equalToConstant: view.frame.width * 9 / 16 + 80).isActive = true
    }

  
    func showVideo(videoID:String){
        let session = AVAudioSession.sharedInstance()
               do {
                try session.setCategory(.playback, mode: .moviePlayback)
                print("タイプA")
               } catch  {
                   fatalError("Category設定失敗")
                
               }

               do {
                   try session.setActive(true)
                print("タイプB")
               } catch {
                   fatalError("Session有効化失敗")
               }
        let embedHTML = "<html><head><meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=yes\"/></head><body><div><iframe width=\"\(view.frame.width - 15)\" height=\"\(view.frame.width * 9 / 16 + 15)\" src=\"https://www.youtube.com/embed/\(videoID)?loop=1&rel=0&playlist=\(videoID)\"frameborder=\"0\" gesture=\"media\"allow=\"encrypted-media\" allowfullscreen></iframe></div></body></html>"
            
        let url = URL(string: "https://")
        webView.loadHTMLString(embedHTML, baseURL: url)
        webView.contentMode = .scaleAspectFill
        webView.scrollView.isScrollEnabled = false
    }
    func showVideo2(videoID:String){
        let baseurl:URL = URL(string: "https://www.youtube.com/embed/\(videoID)?loop=1&playlist=\(videoID)&rel=0")!
        let request:URLRequest = URLRequest(url: baseurl)
        webView.load(request)
    }
    func fetchRelated(videoID:String){
        //ローディング開始
        indicator.startAnimating()
        print(videoID)
        ApiManager.shere.fetchRelatedVideos(videoID:videoID) { data in
            //ローディング終了
            self.indicator.stopAnimating()
            self.videos = data
            self.collectionView.reloadData()
        }
    }
}







class VideoLancher : NSObject, WKUIDelegate{
   
    let backView = UIView()
    var windowHeight = CGFloat()
    var id = String()
    var html = String()
    var webView:WKWebView = {
        let webConfiguration = WKWebViewConfiguration()
        webConfiguration.allowsInlineMediaPlayback = true
        webConfiguration.allowsPictureInPictureMediaPlayback = true
        webConfiguration.allowsAirPlayForMediaPlayback = true
        let wv = WKWebView(frame: .zero, configuration: webConfiguration)
        return wv
    }()
    var videos = [Video]()
    
    let indicator:UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.style = .large
        indicator.color = UIColor(red: 44/255, green: 169/255, blue: 225/255, alpha: 1)
        indicator.backgroundColor = .darkGray
        return indicator
    }()
    
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "タイトル"
        label.textColor = .darkGray
        label.isHidden = true
        label.numberOfLines = 0
        return label
    }()
    let backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(UIImage(systemName: "multiply"), for: .normal)
        button.setTitleColor(.darkGray, for: .normal)
        button.setTitleColor(.systemGray4, for: .highlighted)
        button.isHidden = true
       
        return button
    }()
    let collectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        
        return cv
    }()
    
    
    var webViewHightConstraint:NSLayoutConstraint?
    var webViewWidthConstraint:NSLayoutConstraint?
    
    override init() {
        super.init()
        collectionView.delegate = self
        collectionView.dataSource = self
        webView.uiDelegate = self
    }
    
    func showSetting(videoID:String,videoTitle:String){
        if let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }){
            windowHeight = window.frame.height
            backView.backgroundColor = .white
            backView.frame = window.frame
            backView.alpha = 0
            backView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action:#selector(handleSwipes) ))
            
            
            window.addSubview(backView)
            backView.addSubview(webView)
            backView.addSubview(indicator)
            backView.addSubview(collectionView)
            backView.addSubview(titleLabel)
            backView.addSubview(backButton)
            
            backButton.addTarget(self, action: #selector(dismiss(sender:)),for: .touchUpInside)
            titleLabel.text = videoTitle
            indicator.center = window.center
            addVideoConstraint()
            addTitleLabelConstraint()
            addBackButtonConstraint()
            settingCollectionView()
            showVideo(videoID: videoID)
//            fetchVideo(videoID: videoID)
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.backView.alpha = 1
            }, completion: nil)

            
        }
    }
    
  

    
    
    func showVideo(videoID:String){
        NotificationCenter.default.addObserver(webView, selector: #selector(playerItemDidReachEnd(_:)), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: nil)
        let embedHTML = "<html><head><meta name='referrer' content='no-referrer'/><meta name=\"viewport\" content=\"width=device-width, initial-scale=0, maximum-scale=0, user-scalable=yes\"/></head><body><div><iframe width=\"\(backView.frame.width - 10)\" height=\"\(backView.frame.width * 9 / 16 + 15)\" src=\"https://www.youtube.com/embed/\(videoID)?loop=1&rel=0&playlist=\(videoID)\"frameborder=\"0\" gesture=\"media\"allow=\"encrypted-media\" allowfullscreen ></iframe></div></body></html>"
            
        html = embedHTML
        let url = URL(string: "https://")
        webView.loadHTMLString(embedHTML, baseURL: url)
        webView.contentMode = .scaleAspectFill
        webView.scrollView.isScrollEnabled = false

    }
    
    @objc private func playerItemDidReachEnd(_ notification: Notification) {
        print("動画を終了しました")
        let url = URL(string: "https://")
        webView.loadHTMLString(html, baseURL: url)
    }
    func addVideoConstraint(){
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.topAnchor.constraint(equalTo: backView.topAnchor, constant: 0).isActive = true
        webView.leftAnchor.constraint(equalTo: backView.leftAnchor, constant: 0).isActive = true
        webViewHightConstraint?.isActive = false
        webViewWidthConstraint?.isActive = false
        
        
        webViewHightConstraint = webView.heightAnchor.constraint(equalToConstant:backView.frame.width * 9 / 16 + 80 )
        webViewHightConstraint?.isActive = true
        
        
        webViewWidthConstraint = webView.widthAnchor.constraint(equalToConstant: backView.frame.width - 10)
        webViewWidthConstraint?.isActive = true
    }
    
    func addTitleLabelConstraint(){
        titleLabel.topAnchor.constraint(equalTo: backView.topAnchor, constant: 0).isActive = true
        let webViewWidth:CGFloat =  80 * 16 / 9
        titleLabel.leftAnchor.constraint(equalTo: backView.leftAnchor, constant: webViewWidth ).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: backButton.leftAnchor, constant: 0).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: backView.bottomAnchor, constant: 0).isActive = true
    }
    func addBackButtonConstraint(){
        backButton.topAnchor.constraint(equalTo: backView.topAnchor, constant: 20).isActive = true
        backButton.rightAnchor.constraint(equalTo: backView.rightAnchor, constant: -10).isActive = true
        backButton.leftAnchor.constraint(equalTo: titleLabel.rightAnchor, constant: 0).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: 30.0).isActive = true
        backButton.widthAnchor.constraint(equalToConstant: 30.0).isActive = true
    }
    

   
    @objc func dismiss(sender: UIButton) {
        webView.loadHTMLString("", baseURL: nil)
        UIView.animate(withDuration: 0.2) {
                self.backView.alpha = 0

        }
    }
    
    @objc func handleSwipes(_ sender: UIPanGestureRecognizer){
       
        titleLabel.isHidden = true
        backButton.isHidden = true
        
        let translation = sender.translation(in: self.backView)
        var height = backView.frame.height - translation.y
        
        if windowHeight > height{
            let new = CGRect(x: backView.frame.origin.x, y:windowHeight - height , width: backView.frame.width, height: height)
            backView.frame = new
            sender.setTranslation(CGPoint.zero, in: self.backView)
        }
     
        
        if sender.state == .ended{
            print("ended")
            if height <= windowHeight{
                if windowHeight / 3 <= backView.frame.origin.y {
                    height = 80
                    let new = CGRect(x: backView.frame.origin.x, y:windowHeight - height , width: backView.frame.width, height: height)
                    backView.frame = new
                    sender.setTranslation(CGPoint.zero, in: self.backView)
                    webViewHightConstraint?.constant = 80
                    webViewWidthConstraint?.constant = 80 * 16 / 9
                    titleLabel.isHidden = false
                    backButton.isHidden = false
                }
                else{
                    let new = CGRect(x: backView.frame.origin.x, y:0 , width: backView.frame.width, height: windowHeight)
                    backView.frame = new
                    sender.setTranslation(CGPoint.zero, in: self.backView)
                    webViewWidthConstraint?.constant =  backView.frame.width - 5
                    webViewHightConstraint?.constant = backView.frame.width * 9 / 16 + 80
                    titleLabel.isHidden = true
                    backButton.isHidden = true
                }
               
            }
        }
    
        
      
    }
   
}



extension VideoLancher:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! videoCell
        cell.video = Video()
        cell.video = videos[indexPath.row]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let height = backView.frame.width  * 9 / 16
        return CGSize(width: backView.frame.width , height: height  + 8 + 8  + 80  )
    }
    
    func settingCollectionView(){
        collectionView.backgroundColor = .white
        collectionView.register(videoCell.self, forCellWithReuseIdentifier: "Cell")
        
        collectionView.topAnchor.constraint(equalTo: webView.bottomAnchor, constant: 0).isActive = true
        collectionView.leftAnchor.constraint(equalTo: backView.leftAnchor, constant: 0).isActive = true
        collectionView.rightAnchor.constraint(equalTo: backView.rightAnchor, constant: 0).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: backView.bottomAnchor, constant: 0).isActive = true
        
    }
    
    func fetchVideo(videoID:String){
        indicator.startAnimating()
        ApiManager.shere.fetchRelatedVideos(videoID: videoID) { data in
            self.indicator.stopAnimating()
            self.videos = data
            self.collectionView.reloadData()
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row,"tappppp")
        //videos[indexpath.row].id
    
        //showVideo()
        showVideo(videoID: videos[indexPath.row].id!)
        //fetchVideoをする 関連動画
        fetchVideo(videoID: videos[indexPath.row].id!)
        titleLabel.text = videos[indexPath.row].title
        
    }
    
    
    
}
