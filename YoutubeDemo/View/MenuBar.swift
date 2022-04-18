//
//  MenuBar.swift
//  YoutubeDemo
//
//  Created by Yabuki Shodai on 2022/04/18.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class MenuBar:UIView, UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    var menuBarTitleArray = ["すべて","新しい動画の発見","料理","音楽","最近アップロードされた動画","視聴済み"]
    
    lazy var collectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        let collecitonview = UICollectionView(frame: .zero, collectionViewLayout:layout )
        collecitonview.dataSource = self
        collecitonview.delegate = self
        return collecitonview
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(collectionView)
        addCollectionViewConstaraiont()
        
        collectionView.register(MenuBarCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.backgroundColor = .white
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! MenuBarCell
        cell.setCell(title: menuBarTitleArray[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let height = (view.frame.width - 16 - 16 ) * 9 / 16
        return CGSize(width:collectionView.frame.width , height: frame.height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return  8
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addCollectionViewConstaraiont(){
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0.0).isActive = true
        collectionView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0.0).isActive = true
        collectionView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0.0).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
}



class MenuBarCell:BaseCell{
    let disposeBag = DisposeBag()
    let menuTitle:UIButton = {
        let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.backgroundColor = .systemGray5
        button.layer.cornerRadius = 15
        button.layer.borderColor = UIColor.systemGray3.cgColor
        button.layer.borderWidth = 1
        button.contentEdgeInsets = UIEdgeInsets(top: 5.0, left: 12.0, bottom: 5.0, right: 12.0)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
    
        
        return button
    }()
    
    
    override func  setupViews(){
        addSubview(menuTitle)
        addMenuTitleConstraint()
        
        menuTitle.rx.tap
            .subscribe(onNext: {
                self.isSelected = !self.isSelected
                if self.isSelected{
                    self.menuTitle.setTitleColor(.white, for: .normal)
                    self.menuTitle.backgroundColor = .darkGray
                }
                else{
                    self.menuTitle.setTitleColor(.black, for: .normal)
                    self.menuTitle.backgroundColor = .systemGray5
                }
                
              
            })
        .disposed(by: disposeBag)
        
    }

    func addMenuTitleConstraint(){
        let guide = self.safeAreaLayoutGuide
        menuTitle.translatesAutoresizingMaskIntoConstraints = false
        menuTitle.topAnchor.constraint(equalTo: guide.topAnchor, constant: 0.0).isActive = true
        menuTitle.leftAnchor.constraint(equalTo: guide.leftAnchor, constant: 0.0).isActive = true
        menuTitle.rightAnchor.constraint(equalTo: guide.rightAnchor, constant: 0.0).isActive = true
        menuTitle.bottomAnchor.constraint(equalTo: guide.bottomAnchor, constant: 0.0).isActive = true
    }
    func setCell(title:String){
        menuTitle.setTitle(title, for: .normal)
    }
    
}
