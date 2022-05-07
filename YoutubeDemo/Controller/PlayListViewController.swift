import Foundation
import UIKit

class PlayListViewController:UICollectionViewController,UICollectionViewDelegateFlowLayout{
    let videoLancher = VideoLancher()
    var playList: [Video] = [] {
        didSet{
            collectionView.reloadData()
        }
    }
    override func viewDidLoad() {
        
        collectionView.backgroundColor = .systemGray4
        collectionView.register(playListCell.self, forCellWithReuseIdentifier: "Cell")
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return playList.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
    
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! playListCell
        
        cell.video = playList[indexPath.row]
        cell.backgroundColor = .white
        return cell
        
      
       
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.view.frame.width
        return CGSize(width:width , height: width * 3 / 16 + 15)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //VideoViewControllerに遷移する
        
        let layout = UICollectionViewFlowLayout()
        let vc = VideoViewController(collectionViewLayout: layout)
        vc.videoID = playList[indexPath.row].id!
        vc.youtubetitle = playList[indexPath.row].title!
        let nav = UINavigationController(rootViewController: vc)
        self.present(nav, animated: true, completion: nil)
        
    }
    
}


class playListCell:BaseCell{
    
    let thumbnailImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .systemGray4
        imageView.clipsToBounds = true
        
        return imageView
    }()
    let title:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        label.textAlignment = .left
        label.numberOfLines  = 2
        label.textColor = .black
        return label
    }()
    
    
    var video:Video? {
        didSet{
            title.text = video?.title
           
            setupThumbnailImage()
        }
    }
    override func setupViews() {
        addSubview(title)
        addSubview(thumbnailImage)
        addTitleConstraint()
        addthumbnailImageConstraint()
    }
    func setupThumbnailImage(){
        if let thumbnailImageURL = video?.thumbnailImage{
            thumbnailImage.loadImageUsingUrlString(urlString: thumbnailImageURL)
            
        }
    }
    
    func addTitleConstraint(){
        title.topAnchor.constraint(equalTo: self.topAnchor, constant: 0.0).isActive = true
        title.leftAnchor.constraint(equalTo: thumbnailImage.rightAnchor, constant: 10.0).isActive = true
        title.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0.0).isActive = true
        title.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0.0).isActive = true
    }
   
    func addthumbnailImageConstraint(){
        thumbnailImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 10.0).isActive = true
        thumbnailImage.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10.0).isActive = true
        thumbnailImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10.0).isActive = true
        let width = self.frame.width / 4
        thumbnailImage.widthAnchor.constraint(equalToConstant: width).isActive = true
//        thumbnailImage.heightAnchor.constraint(equalToConstant: width * 9 / 16 + 15 ).isActive = true
        
    }
    func dateformat(string:String) -> String {
        let dateFormatter = DateFormatter()
        let tempLocale = dateFormatter.locale
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = dateFormatter.date(from: string)!
        dateFormatter.dateFormat = "yyyy年MM月dd日"
        dateFormatter.locale = tempLocale // reset the locale
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
    
}
