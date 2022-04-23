//
//  SettingLancher.swift
//  YoutubeDemo
//
//  Created by Yabuki Shodai on 2022/04/23.
//

import Foundation
import UIKit


class SettingLancher: NSObject,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{


    let backView = UIView()
    let menuItems = [
        menuItem(name: "共有", icon: "arrowshape.turn.up.forward"),
        menuItem(name: "ヘルプとフィードバック", icon: "questionmark.circle"),
        menuItem(name: "キャンセル", icon: "multiply"),
    ]
    
    let collectionView:UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        let collectionview = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionview.translatesAutoresizingMaskIntoConstraints = false
        return collectionview
    }()
    
    override init() {
        super.init()
        
    }
    func showSetting(){
        if let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }){
           
            backView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            backView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
            backView.frame = window.frame
            backView.alpha = 0
            
            
            collectionView.backgroundColor = .white
            collectionView.register(menubarCell.self, forCellWithReuseIdentifier: "Cell")
            collectionView.delegate = self
            collectionView.dataSource = self
            window.addSubview(backView)
            window.addSubview(collectionView)
            
          
            
            let height: CGFloat = 200   
            let y = window.frame.height - height
            collectionView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: height)
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.backView.alpha = 1
                self.collectionView.frame = CGRect(x: 0, y: y, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
                
            }, completion: nil)

            
        }
    }
    @objc func handleDismiss() {
        UIView.animate(withDuration: 0.5) {
            self.backView.alpha = 0
            
            if let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }){
                self.collectionView.frame = CGRect(x: 0, y: window.frame.height, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
            }
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! menubarCell
        cell.setCell(setting: menuItems[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuItems.count
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)

        if indexPath.row == 0{
            print("共有")
        }
        else if indexPath.row == 1{
            print("ヘルプとフィードバック")

        }
        else {
            handleDismiss()
        }
        
    }
}
