//
//  ViewController.swift
//  YoutubeDemo
//
//  Created by Yabuki Shodai on 2022/04/17.
//

import UIKit


//
class HomeViewController: UICollectionViewController,UICollectionViewDelegateFlowLayout {
    
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
        
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (view.frame.width - 16 - 16 ) * 9 / 16
        return CGSize(width: view.frame.width, height: height + 16 + 70)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    
    private func setupMenuBar(){
        view.addSubview(menuBar)
        addMenuBarConstraint()
    }
    func addMenuBarConstraint(){
       
        let guide = self.view.safeAreaLayoutGuide //これを入れたら表示されるようになった
        menuBar.translatesAutoresizingMaskIntoConstraints = false
        menuBar.topAnchor.constraint(equalTo: guide.topAnchor, constant: 0.0).isActive = true
        menuBar.leftAnchor.constraint(equalTo: guide.leftAnchor, constant: 0.0).isActive = true
        menuBar.rightAnchor.constraint(equalTo: guide.rightAnchor, constant: 0.0).isActive = true
        menuBar.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
    }
   
        
     
}



