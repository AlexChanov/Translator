//
//  NewTranslatedWordCollectionViewCell.swift
//  Translator
//
//  Created by Алексей ]Чанов on 07/12/2019.
//  Copyright © 2019 Алексей Чанов. All rights reserved.
//

import UIKit

class NewTranslatedWordCollectionViewCell: UICollectionViewCell {
    
    static let reuseId = "newTranslatedWordCollectionViewCell"
    
    // MARK: - Private property
   private let imageView: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .pureGreen
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(imageView)
        imageView.topAnchor.constraint(equalTo: topAnchor).isActive             = true
        imageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive       = true
        imageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive     = true
        imageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive   = true
    }
    
    func setPhotoInCell(photo: Image?) {
        guard let photo = photo else { return }
        let url = photo.urls.small
        self.imageView.loadImageUsingCacheWithURLString(url, placeHolder: UIImage(named: "placeholder"))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
