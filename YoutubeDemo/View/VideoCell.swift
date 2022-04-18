//
//  VideoCell.swift
//  YoutubeDemo
//
//  Created by Yabuki Shodai on 2022/04/18.
//

import Foundation
import UIKit


class BaseCell:UICollectionViewCell{
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupViews(){}
}

class videoCell:BaseCell{
    
    let thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "hikakin")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    let userProfileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "hikakinprofile")
        imageView.layer.cornerRadius = 22
        imageView.layer.masksToBounds = true
        return imageView
    }()
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "好きなことで、生きていく - HIKAKIN - Youtube"
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 2
        return label
    }()
    let subTitleText:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "HikakinTV・1億 回視聴・10年前"
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 12)
        
        return label
    }()
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func setupViews(){
        
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
            constant: 0.0
        )
        topConstraint.isActive = true
        
        let rightConstraint = NSLayoutConstraint.init(
            item: thumbnailImageView,
            attribute: .right,
            relatedBy: .equal,
            toItem: self,
            attribute: .right,
            multiplier: 1.0,
            constant: 0.0)
        
        rightConstraint.isActive = true
        
        let leftConstraint = NSLayoutConstraint.init(
            item: thumbnailImageView,
            attribute: .left,
            relatedBy: .equal,
            toItem: self,
            attribute: .left,
            multiplier: 1.0,
            constant: 0.0)
        
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

        separatorView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0.0).isActive = true
        separatorView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0.0).isActive = true
        separatorView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        separatorView.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        
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
        titleLabel.bottomAnchor.constraint(equalTo: subTitleText.topAnchor, constant: 0.0).isActive = true
        
    }
    func setSubTitleTextViewConstraint(){
        subTitleText.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,constant: 0.0).isActive = true
        subTitleText.leftAnchor.constraint(equalTo: userProfileImageView.rightAnchor, constant: 8.0).isActive = true
        subTitleText.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16.0).isActive = true
        subTitleText.bottomAnchor.constraint(equalTo: separatorView.topAnchor, constant: -8.0).isActive = true
    }
}
