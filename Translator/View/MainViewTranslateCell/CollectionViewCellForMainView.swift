//
//  CollectionViewCellForMainView.swift
//  Translator
//
//  Created by Алексей ]Чанов on 05/12/2019.
//  Copyright © 2019 Алексей Чанов. All rights reserved.
//

import UIKit

class CollectionViewCellForMainView: UICollectionViewCell {
    
  static let reuseId = "MainCollectionViewCell"
    
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .pureGreen
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.layer.cornerRadius = 40
        return iv
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(imageView)
        imageView.topAnchor.constraint(equalTo: topAnchor).isActive             = true
        imageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive       = true
        imageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive     = true
        imageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive   = true
        
        
    }
    
    func setPhotoCellWith(photo: Image?) {
        guard photo != nil else{ return }
        let url = photo!.urls.small
            self.imageView.loadImageUsingCacheWithURLString(url, placeHolder: UIImage(named: "placeholder"))
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
