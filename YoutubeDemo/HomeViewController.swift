//
//  ViewController.swift
//  YoutubeDemo
//
//  Created by Yabuki Shodai on 2022/04/17.
//

import UIKit


//
class HomeViewController: UICollectionViewController,UICollectionViewDelegateFlowLayout {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("test")
        navigationItem.title = "Home"
        collectionView.backgroundColor = .white
        collectionView.register(videoCell.self, forCellWithReuseIdentifier: "Cell")

    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 200)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}



class videoCell:UICollectionViewCell{
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    let thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .blue
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "hikakin")
        
        return imageView
    }()
    let userProfileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .green
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    let titleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .purple
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "label"
        return label
    }()
    let subTitleText:UILabel = {
        let label = UILabel()
        label.backgroundColor = .red
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "label"
        return label
    }()
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    func setupViews(){
        
        addSubview(thumbnailImageView)
        addSubview(separatorView)
        addSubview(userProfileImageView)
        addSubview(titleLabel)
        addSubview(subTitleText)
        
        setthumbnailImageViewConstraint()
        setSeparatorViewConstrain()
        setProfileImageConstraint()
        setTitleLabelConstraint()
        setSubTitleTextViewConstraint()
        
    }
    func setthumbnailImageViewConstraint(){
        let topConstraint = NSLayoutConstraint.init(
            item: thumbnailImageView,
            attribute: .top,
            relatedBy: .equal,
            toItem: self,
            attribute: .top,
            multiplier: 1.0,
            constant: 16.0
        )
        topConstraint.isActive = true
        
        let rightConstraint = NSLayoutConstraint.init(
            item: thumbnailImageView,
            attribute: .right,
            relatedBy: .equal,
            toItem: self,
            attribute: .right,
            multiplier: 1.0,
            constant: -16.0)
        
        rightConstraint.isActive = true
        
        let leftConstraint = NSLayoutConstraint.init(
            item: thumbnailImageView,
            attribute: .left,
            relatedBy: .equal,
            toItem: self,
            attribute: .left,
            multiplier: 1.0,
            constant: 16.0)
        
        leftConstraint.isActive = true
        
        let bottomConstraint = NSLayoutConstraint.init(
            item: thumbnailImageView,
            attribute: .bottom,
            relatedBy: .equal,
            toItem: userProfileImageView,
            attribute: .top,
            multiplier: 1.0,
            constant: -8.0)
        
        bottomConstraint.isActive = true
    }
    func setSeparatorViewConstrain(){

        separatorView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 12.0).isActive = true
        separatorView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -12.0).isActive = true
        separatorView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        separatorView.heightAnchor.constraint(equalToConstant: 0.8).isActive = true
        
    }
    func setProfileImageConstraint(){
        userProfileImageView.topAnchor.constraint(equalTo: thumbnailImageView.bottomAnchor, constant: 8.0).isActive = true
        userProfileImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16.0).isActive = true
        userProfileImageView.bottomAnchor.constraint(equalTo: separatorView.topAnchor, constant: -8.0).isActive = true
        
        userProfileImageView.heightAnchor.constraint(equalToConstant: 44).isActive = true
        userProfileImageView.widthAnchor.constraint(equalToConstant: 44).isActive = true
    }
    func setTitleLabelConstraint(){
        
        titleLabel.topAnchor.constraint(equalTo: thumbnailImageView.bottomAnchor, constant: 8.0).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: userProfileImageView.rightAnchor, constant: 8.0).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16.0).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: subTitleText.topAnchor, constant: -8.0).isActive = true
        
    }
    func setSubTitleTextViewConstraint(){
        subTitleText.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,constant: 8.0).isActive = true
        subTitleText.leftAnchor.constraint(equalTo: userProfileImageView.rightAnchor, constant: 8.0).isActive = true
        subTitleText.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16.0).isActive = true
        subTitleText.bottomAnchor.constraint(equalTo: separatorView.topAnchor, constant: -8.0).isActive = true
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
