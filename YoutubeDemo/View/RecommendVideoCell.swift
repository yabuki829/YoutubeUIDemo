import Foundation
import UIKit

class videoRecomment:UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    var delegate:moveDelegate?
    var recommentPlayLists = [
        VideoRecomment(
            title: "月間ランキングシングルTOP-30",
            thumneilImage: "https://i.ytimg.com/vi/9MjAJSoaoSo/maxresdefault.jpg",
            playListID:"PLudzRsmO_lzeLJwJCyyKFj6w1vbObdIAD"),
        
        VideoRecomment(
            title: "年間ランキングシングルTOP-50",
            thumneilImage: "https://i.ytimg.com/vi/9MjAJSoaoSo/maxresdefault.jpg",
            playListID:"PLudzRsmO_lzffwrq_mHcgiosTUWL3cpgx"),
        VideoRecomment(
            title: "人気曲TOP-100",
            thumneilImage: "https://i.ytimg.com/vi/x8VYWazR5mE/maxresdefault.jpg",
            playListID:"PLsdvf-Id15BQoo3q1iB0NFsGS_a5OSrIV"),
        VideoRecomment(
            title: "トップ100日本の音楽 2022 ♫ ベストソング 2022",
            thumneilImage: "https://i.ytimg.com/vi/QW28YKqdxe0/hqdefault.jpg",
            playListID:"PLsdvf-Id15BQoo3q1iB0NFsGS_a5OSrIV"),

        VideoRecomment(
            title: "Youtube再生回数1万回以上洋楽ヒット超名曲",
            thumneilImage: "https://i.ytimg.com/vi/hkBbUf4oGfA/maxresdefault.jpg",
            playListID:"PLEf2r8gdfvQpXyASnc7Byw3dsIRdUbmOO")
        
    ]
    let backView:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .link
        view.isUserInteractionEnabled = false
        view.layer.zPosition = -1
        view.alpha = 0.3
        return view
    }()

    let collectionView:UICollectionView = {
        let layout = CustomFlowLayoutX()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return cv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        collectionView.register(recommendCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor(cgColor: CGColor(red: 0, green: 170, blue: 255, alpha: 1))
        
        
        collectionView.contentInset = UIEdgeInsets(top:0, left: self.frame.width / 2 - self.frame.height + 100 / 2, bottom: 0, right: self.frame.width / 2 - self.frame.height + 100 / 2)
        addSubview(collectionView)
        collectionView.addSubview(backView)
        addCollectionViewConstraint()
       addBackViewConstraint()
        if collectionView.numberOfItems(inSection: 0) > 0 {
                collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .centeredHorizontally, animated: false)
            }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if recommentPlayLists.isEmpty{
            return 0
        }
        return recommentPlayLists.count
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return  -30
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! recommendCell
        
        cell.video = recommentPlayLists[indexPath.row]
        cell.setCell(width:self.frame.height - 100)
        cell.backgroundColor = .yellow
        cell.layer.borderWidth = 0.5
        cell.layer.borderColor = UIColor.black.cgColor
        

        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        // playListの動画recommentPlayLists[indexpath.row].idを取得する
        ApiManager.shere.fetchPlayList(playListID:recommentPlayLists[indexPath.row].playListID!) { videos in
            print("取得完了,遷移します")
            self.delegate?.move(playList: videos, titleText: self.recommentPlayLists[indexPath.row].title!)
    
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       
        return CGSize(width:self.frame.height + 100   , height: self.frame.height - 30 )
    }


   
    func addCollectionViewConstraint(){
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        collectionView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        collectionView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
    }
    
    func addBackViewConstraint(){
        backView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0.0).isActive = true
        backView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0.0).isActive = true
        backView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0.0).isActive = true
        backView.heightAnchor.constraint(equalToConstant:self.frame.height / 2 ).isActive = true
    }
    
}


class recommendCell:BaseCell{
    let thumbnailImage:UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.layer.masksToBounds = true
        image.backgroundColor = .white
        return image
    }()
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        label.numberOfLines = 2
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()

    var video = VideoRecomment(title: "", thumneilImage: "", playListID:"")
    
    func setCell(width:CGFloat){
        addSubview(thumbnailImage)
        addSubview(titleLabel)

        setupThumbnailImage()
        titleLabel.text = video.title
        addViewConstraint(width: width)
        
    }
    func setupThumbnailImage(){
        if let thumbnailImageURL = video.thumneilImage{
            thumbnailImage.loadImageUsingUrlString(urlString: thumbnailImageURL)
        }
    }
    func addViewConstraint(width:CGFloat){
        
        thumbnailImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 0.0).isActive = true
        thumbnailImage.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0.0).isActive = true
        thumbnailImage.rightAnchor.constraint(equalTo: self.rightAnchor, constant:0.0).isActive = true
        thumbnailImage.heightAnchor.constraint(equalToConstant: width).isActive = true
        
        titleLabel.topAnchor.constraint(equalTo: thumbnailImage.bottomAnchor, constant: 0.0).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 3.0).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0.0).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0.0).isActive = true
        
        

    }
    
}


struct VideoRecomment{
    let title:String?
    let thumneilImage:String?
    let playListID:String?
}




class CustomFlowLayoutX: UICollectionViewFlowLayout {
    // Create custom layout
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {

        guard let collectionView = collectionView else { return proposedContentOffset }
        print(proposedContentOffset.x)
        let targetRect = CGRect(x: proposedContentOffset.x, y: 0, width: collectionView.frame.width, height: collectionView.frame.height)
        let verticalCenter = proposedContentOffset.x + collectionView.frame.height
        var offsetAdjustment = CGFloat.greatestFiniteMagnitude

        // Retrieve the layout attributes for all of the cells in the target rectangle.
        guard let attributesList = super.layoutAttributesForElements(in: targetRect) else { return proposedContentOffset }
        for attributes in attributesList {
            // Find the nearest attributes to the center of collectionView.
            if abs(attributes.center.x - verticalCenter) < abs(offsetAdjustment) {
                offsetAdjustment = attributes.center.x - verticalCenter
            }
        }

        return CGPoint(x: proposedContentOffset.x + offsetAdjustment, y: proposedContentOffset.y )
    }
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
      
        guard let collectionView = collectionView,
              let attributesList = super.layoutAttributesForElements(in: rect) else { return nil }

        let visibleRect = CGRect(origin: collectionView.contentOffset, size: collectionView.frame.size)

        attributesList.forEach { attributes in
            let distance = visibleRect.midX - attributes.center.x
            let newScale = max(1 - abs(distance) * 0.001, 0.5)
            attributes.transform = .init(scaleX: newScale, y: newScale)
        }

        return attributesList
    }
}


class CustomFlowLayoutY: UICollectionViewFlowLayout {
    // Create custom layout
   
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {

        guard let collectionView = collectionView else { return proposedContentOffset }
        print(proposedContentOffset.y,collectionView.frame.height)
        let targetRect = CGRect(x: 0, y: proposedContentOffset.y, width: collectionView.frame.width, height: collectionView.frame.height)
        let verticalCenter = proposedContentOffset.y + collectionView.frame.height / 2
        
        var offsetAdjustment = CGFloat.greatestFiniteMagnitude

        // Retrieve the layout attributes for all of the cells in the target rectangle.
        guard let attributesList = super.layoutAttributesForElements(in: targetRect) else { return proposedContentOffset }
        for attributes in attributesList {
            // Find the nearest attributes to the center of collectionView.
            if abs(attributes.center.y - verticalCenter) < abs(offsetAdjustment) {
                offsetAdjustment = attributes.center.y - verticalCenter
            }
        }

        return CGPoint(x: proposedContentOffset.x, y: proposedContentOffset.y + offsetAdjustment)
    }
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
      
        guard let collectionView = collectionView,
              let attributesList = super.layoutAttributesForElements(in: rect) else { return nil }

        let visibleRect = CGRect(origin: collectionView.contentOffset, size: collectionView.frame.size)

        attributesList.forEach { attributes in
            let distance = visibleRect.midY - attributes.center.y
            let newScale = max(1 - abs(distance) * 0.001, 0.9)

            attributes.transform = .init(scaleX: newScale, y: newScale)
        }

        return attributesList
    }
}


protocol moveDelegate: class  {
    func move(playList:[Video],titleText:String)
}
