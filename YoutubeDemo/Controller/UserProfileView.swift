//
//  UserProfileView.swift
//  YoutubeDemo
//
//  Created by Yabuki Shodai on 2022/04/22.
//

import Foundation
import UIKit

struct menuItem{
    let name:String
    let icon:String
}




class UserProfileView  :UICollectionViewController,UICollectionViewDelegateFlowLayout{

  
    let settingdata = [
        menuItem(name: "チャンネル", icon: "person.crop.square"),
        menuItem(name: "シークレットモード", icon: "star.square"),
        menuItem(name: "アカウントを追加", icon: "person.crop.circle.badge.plus"),
        menuItem(name: "YouTube Premium に登録", icon: "play.rectangle"),
        menuItem(name: "購入とメンバーシップ", icon: "dollarsign.circle"),
        menuItem(name: "視聴時間", icon: "clock"),
        menuItem(name: "Youtubeでのデータ", icon: "chart.bar.xaxis"),
        menuItem(name: "設定", icon: "gearshape"),
        menuItem(name: "ヘルプとフィードバック", icon: "questionmark.circle"),
    ]
    
 
    override func viewDidLoad() {
        
        let accountImage = UIImage(systemName: "multiply")
        let accountItem = UIBarButtonItem(image: accountImage, style: .plain, target: self, action: #selector(onClickMyButton(sender:)))
        accountItem.tintColor = .darkGray
        navigationItem.leftBarButtonItem = accountItem
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        view.backgroundColor = .white
        collectionView.backgroundColor = .white
        collectionView.register(menubarCell.self, forCellWithReuseIdentifier: "Cell")
        
        view.addSubview(collectionView)
        addCollectionViewConstraint()
    }
    @objc func onClickMyButton(sender : UIButton){

        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    
 
    func addCollectionViewConstraint(){
        collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return settingdata.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! menubarCell
        cell.setCell(setting: settingdata[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:collectionView.frame.width, height:40)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 30
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(settingdata[indexPath.row].name)
        let viewcontroller = UIViewController()
        viewcontroller.view.backgroundColor = .white
        
        
        let layout = UICollectionViewFlowLayout()
        let nav = UINavigationController(rootViewController: ChannelViewController(collectionViewLayout: layout))
        nav.modalPresentationStyle = .fullScreen
        self.present(nav, animated: true, completion: nil)
    
    }
    
    
  
}



class menubarCell:BaseCell{
    
    override var isHighlighted: Bool{
        didSet{
            if isHighlighted{
                backgroundColor = .systemGray5
            }
            else{
                backgroundColor = .white
            }
        }
    }
    let title:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Setting"
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    let iconImage:UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.image = UIImage(named:"tv")
        image.tintColor = .darkGray
        return image
    }()

    override func setupViews() {
        addSubview(title)
        addSubview(iconImage)
        
        addtitleConstraint()
        addIconImageConstraint()
    }
    func setCell(setting:menuItem){
        title.text = setting.name
        iconImage.image = UIImage(systemName: setting.icon)
    }
    func addIconImageConstraint(){
        iconImage.topAnchor.constraint(equalTo: self.topAnchor, constant:10).isActive = true
        iconImage.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 32).isActive = true
        iconImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
        iconImage.widthAnchor.constraint(equalToConstant: 20).isActive = true
    }
    func addtitleConstraint(){
        title.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        title.leftAnchor.constraint(equalTo: iconImage.rightAnchor, constant: 20).isActive = true
        title.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        title.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
    }
    
}


