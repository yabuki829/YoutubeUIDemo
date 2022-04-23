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
    
    var video:Video?{
        didSet{
            titleLabel.text = video?.title
            
            setupThumbnailImage()
            setupProfileImage()
            if let channelName = video?.channel?.name{
                let f = NumberFormatter()
                f.numberStyle = .decimal
                subTitleText.text = "\(channelName)・\(dateformat(string: (video?.date)!))"
            }
            
            //titleの高さを計算する
            if let title = video?.title{
                let size = CGSize(width: frame.width - 16 - 8 - 44 - 16, height: 10000)
                let opinions = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
                
                let estimatedRect = NSString(string:title).boundingRect(with: size, options: opinions, attributes: nil, context: nil)
                print("-------------------------")
                print(estimatedRect.height)
                if estimatedRect.height > 20 {
                    print("44",title)
                    titleLabelHightConstraint?.constant = 44
                }
                else{
                    print("20",title)
                    titleLabelHightConstraint?.constant = 20
                }
            }
            //subtitleの高さを計算する
            
            if let name = video?.channel?.name{
                let size = CGSize(width: frame.width - 16 - 8 - 44 - 16, height: 10000)
                let opinions = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
                
                let subTitle = "\(name)・10万回視聴・10年前"
                let estimatedRect = NSString(string:subTitle).boundingRect(with: size, options: opinions, attributes: nil, context: nil)
                if estimatedRect.height > 20 {
                    subTitleLabelHightConstraint?.constant = 44
                }
                else{
                    subTitleLabelHightConstraint?.constant = 20
                }
            }
            
            
            
            
            
           
        }
    }
    func setupThumbnailImage(){
        if let thumbnailImageURL = video?.thumbnailImage{
            topImageView.loadImageUsingUrlString(urlString: thumbnailImageURL)
        }
    }
    func setupProfileImage(){
        if let profileImageURL = video?.channel?.profileImage{
            userProfileImageView.loadImageUsingUrlString(urlString: profileImageURL)
        }
    }
    
    let topImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        return imageView
    }()
    let userProfileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 22
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 2
//        label.backgroundColor = .red
        return label
    }()
    let subTitleText:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 12)
        label.numberOfLines = 2
//        label.backgroundColor = .blue
        return label
    }()
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var titleLabelHightConstraint:NSLayoutConstraint?
    var subTitleLabelHightConstraint:NSLayoutConstraint?
    
    override func setupViews(){
        
        addSubview(topImageView)
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
        topImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0.0).isActive = true
        topImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0.0).isActive = true
        topImageView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0.0).isActive = true
        topImageView.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -8.0).isActive = true
    }

    func setProfileImageConstraint(){
        
        userProfileImageView.topAnchor.constraint(equalTo: topImageView.bottomAnchor, constant: 8.0).isActive = true
        userProfileImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16.0).isActive = true
        userProfileImageView.rightAnchor.constraint(equalTo: titleLabel.leftAnchor, constant:-8.0).isActive = true
        
        userProfileImageView.heightAnchor.constraint(equalToConstant: 44).isActive = true
        userProfileImageView.widthAnchor.constraint(equalToConstant: 44).isActive = true
    }
    func setTitleLabelConstraint(){
        
        titleLabel.topAnchor.constraint(equalTo: topImageView.bottomAnchor, constant: 8.0).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: userProfileImageView.rightAnchor, constant: 8.0).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8.0).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: subTitleText.topAnchor, constant: 0.0).isActive = true
        
        titleLabelHightConstraint = NSLayoutConstraint.init(item: titleLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 44.0)
        titleLabelHightConstraint?.isActive = true
      
        
    }
    func setSubTitleTextViewConstraint(){
        subTitleText.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,constant: 0.0).isActive = true
        subTitleText.leftAnchor.constraint(equalTo: userProfileImageView.rightAnchor, constant: 8.0).isActive = true
        subTitleText.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8.0).isActive = true
        subTitleText.bottomAnchor.constraint(equalTo: separatorView.topAnchor, constant: -16.0).isActive = true
        subTitleLabelHightConstraint = subTitleText.heightAnchor.constraint(equalToConstant: 44)
        subTitleLabelHightConstraint?.isActive = true
    }
    func setSeparatorViewConstrain(){
      
        separatorView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0.0).isActive = true
        separatorView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0.0).isActive = true
        separatorView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0.0).isActive = true
        separatorView.heightAnchor.constraint(equalToConstant: 0.3).isActive = true
        
    }
    
    func dateformat(string:String) -> String {
        let dateFormatter = DateFormatter()
        let tempLocale = dateFormatter.locale // save locale temporarily
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = dateFormatter.date(from: string)!
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm:ss"
        dateFormatter.locale = tempLocale // reset the locale
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
}
