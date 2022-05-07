//
//  MenuBar.swift
//  YoutubeDemo
//
//  Created by Yabuki Shodai on 2022/04/18.
//

import Foundation
import UIKit
public let menuBarTitleArray = ["すべて","スポーツ","ゲーム","料理","音楽","最近アップロードされた動画","視聴済み"]

class MenuBar:UIView, UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    
    var selectedIndexPath: IndexPath?
    
    
    
    lazy var collectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right:10)
        
        let collecitonview = UICollectionView(frame: .zero, collectionViewLayout:layout )
        collecitonview.dataSource = self
        collecitonview.delegate = self
        collecitonview.showsHorizontalScrollIndicator = false
        collecitonview.backgroundColor = .white
        return collecitonview
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(collectionView)
        addCollectionViewConstaraiont()
        
        collectionView.register(MenuBarCell.self, forCellWithReuseIdentifier: "Cell")
        
        let indexPath:IndexPath = NSIndexPath(row: 0, section: 0) as IndexPath
        self.selectedIndexPath = indexPath
        DispatchQueue.main.async {
           
            self.collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .left)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuBarTitleArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! MenuBarCell
        cell.setCell(title: menuBarTitleArray[indexPath.row])
        cell.menuTitle.textColor = .black
        cell.menuTitle.backgroundColor = .systemGray5
        if  selectedIndexPath?.row == indexPath.row{
                cell.isSelected = true
        }
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let height = (view.frame.width - 16 - 16 ) * 9 / 16
        return CGSize(width:collectionView.frame.width, height: frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndexPath = indexPath
        collectionView.scrollToItem(at: indexPath, at:.centeredHorizontally, animated: true)
        delegate?.reload()
    }
 
    func addCollectionViewConstaraiont(){
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5.0).isActive = true
        collectionView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0.0).isActive = true
        collectionView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0.0).isActive = true
//        collectionView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 5.0).isActive = true
    }
    weak var delegate:reloadDelegate? = nil
}



class MenuBarCell:BaseCell{
    
    override var isSelected: Bool{
        didSet{
            menuTitle.textColor =  isSelected ? .white : .black
            menuTitle.backgroundColor = isSelected ? .darkGray : .systemGray5
        }
       
    }
    
  
    let menuTitle:SSPaddingLabel = {
        let label = SSPaddingLabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .center
        label.backgroundColor = .systemGray5
        label.layer.cornerRadius = 8
        label.layer.borderColor = UIColor.systemGray3.cgColor
        label.layer.borderWidth = 1
        label.clipsToBounds = true
        
        return label
    }()
    
    
    override func  setupViews(){
        addSubview(menuTitle)
        addMenuTitleConstraint()
    }
    func addMenuTitleConstraint(){
        let guide = self.safeAreaLayoutGuide
        menuTitle.translatesAutoresizingMaskIntoConstraints = false
        menuTitle.topAnchor.constraint(equalTo: guide.topAnchor, constant: 0.0).isActive = true
        menuTitle.leftAnchor.constraint(equalTo: guide.leftAnchor, constant: 0.0).isActive = true
        menuTitle.rightAnchor.constraint(equalTo: guide.rightAnchor, constant: 0.0).isActive = true
        menuTitle.bottomAnchor.constraint(equalTo: guide.bottomAnchor, constant: 0.0).isActive = true
        menuTitle.padding = UIEdgeInsets(top: 3, left: 12, bottom: 3, right: 12)
        menuTitle.sizeToFit()
    }
    func setCell(title:String){
        
        menuTitle.text = title
        menuTitle.sizeToFit()
    }
}




class SSPaddingLabel: UILabel {
    var padding : UIEdgeInsets
    
    
    // Create a new SSPaddingLabel instance programamtically with the desired insets
    required init(padding: UIEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)) {
        self.padding = padding
        super.init(frame: CGRect.zero)
    }
    
    // Create a new SSPaddingLabel instance programamtically with default insets
    override init(frame: CGRect) {
        padding = UIEdgeInsets.zero // set desired insets value according to your needs
        super.init(frame: frame)
    }
    
    // Create a new SSPaddingLabel instance from Storyboard with default insets
    required init?(coder aDecoder: NSCoder) {
        padding = UIEdgeInsets.zero // set desired insets value according to your needs
        super.init(coder: aDecoder)
    }
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: padding))
    }
    
    // Override `intrinsicContentSize` property for Auto layout code
    override var intrinsicContentSize: CGSize {
        let superContentSize = super.intrinsicContentSize
        let width = superContentSize.width + padding.left + padding.right
        let heigth = superContentSize.height + padding.top + padding.bottom
        return CGSize(width: width, height: heigth)
    }
    
    // Override `sizeThatFits(_:)` method for Springs & Struts code
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        let superSizeThatFits = super.sizeThatFits(size)
        let width = superSizeThatFits.width + padding.left + padding.right
        let heigth = superSizeThatFits.height + padding.top + padding.bottom
        return CGSize(width: width, height: heigth)
    }
}


protocol reloadDelegate: class  {
    func reload()
}
