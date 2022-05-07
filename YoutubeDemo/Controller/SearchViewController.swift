//
//  SearchViewController.swift
//  YoutubeDemo
//
//  Created by Yabuki Shodai on 2022/04/24.
//

import UIKit

private let reuseIdentifier = "Cell"

class SearchViewController: UICollectionViewController,UICollectionViewDelegateFlowLayout ,UISearchBarDelegate{
    
    
    var searchBar: UISearchBar!
    var videos = [Video]()
    var keyWord = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        settingNav()
        collectionView.register(videoCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.backgroundColor = .white
        collectionView.contentInset = UIEdgeInsets(top: 40, left: 0, bottom: 0, right: 0)
        collectionView.scrollIndicatorInsets = UIEdgeInsets(top: 40, left: 0, bottom: 0, right: 0)
        view.addSubview(collectionView)
        
        addCollectionViewConstraint()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videos.count
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        print(view.frame.width)
        return CGSize(width:view.frame.width, height:view.frame.width * 9 / 16 + 80)
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
   
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! videoCell
        cell.video = videos[indexPath.row]
            return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let layout = UICollectionViewFlowLayout()
        let vc = VideoViewController(collectionViewLayout: layout)
        vc.videoID = videos[indexPath.row].id!
        vc.youtubetitle = videos[indexPath.row].title!
        let nav = UINavigationController(rootViewController: vc)
        self.present(nav, animated: true, completion: nil)
        
    }
    @objc func onClickMyButton(sender : UIButton){
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    func addCollectionViewConstraint(){
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
    }
    func settingNav(){
        let accountImage = UIImage(systemName: "chevron.left")
        let accountItem = UIBarButtonItem(image: accountImage, style: .plain, target: self, action: #selector(onClickMyButton(sender:)))
        accountItem.tintColor = .darkGray
        navigationItem.leftBarButtonItem = accountItem
        
        if let navigationBarFrame = navigationController?.navigationBar.bounds {
            let searchBar: UISearchBar = UISearchBar(frame: navigationBarFrame)
            searchBar.delegate = self
            searchBar.placeholder = "タイトルで探す"
            searchBar.tintColor = UIColor.gray
            searchBar.keyboardType = UIKeyboardType.default
            
            navigationItem.titleView = searchBar
            navigationItem.titleView?.frame = searchBar.frame
        
            self.searchBar = searchBar
            
        }
        
    }
        func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
            searchBar.showsCancelButton = true
            
            return true
       }

       // キャンセルボタンが押されたらキャンセルボタンを無効にしてフォーカスを外す
       func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
           searchBar.showsCancelButton = false
           searchBar.resignFirstResponder()
       }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        keyWord = searchText
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if keyWord != ""{
            
            let encodeString:String = keyWord.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)!
            
            ApiManager.shere.searchVideo(word: encodeString) { videos in
                
                self.videos = videos
                searchBar.searchTextField.resignFirstResponder()
                self.collectionView.reloadData()
            }
        }
           
    }

}

