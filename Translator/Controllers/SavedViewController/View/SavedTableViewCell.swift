//
//  SavedTableViewCell.swift
//  Translator
//
//  Created by Алексей ]Чанов on 08/12/2019.
//  Copyright © 2019 Алексей Чанов. All rights reserved.
//

import UIKit

final class SavedTableViewCell: UITableViewCell {

    static let reuseId = "savedTableViewCell"
    
   private let labelWord : UILabel = {
        let labelCell = UILabel()
        labelCell.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        labelCell.font = .systemFont(ofSize: 24)
        labelCell.numberOfLines = 0
        labelCell.translatesAutoresizingMaskIntoConstraints = false
        labelCell.textAlignment = .center
        labelCell.contentMode = .scaleAspectFit
        labelCell.lineBreakMode = .byWordWrapping
        return labelCell
    }()
    
    
   private let ImageCell: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .pureGreen
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(labelWord)
        addSubview(ImageCell)
        
        ImageCell.topAnchor.constraint(equalTo: topAnchor,constant: 2).isActive                    = true
        ImageCell.bottomAnchor.constraint(equalTo: bottomAnchor,constant: -2).isActive             = true
        ImageCell.leadingAnchor.constraint(equalTo: labelWord.trailingAnchor).isActive             = true
        ImageCell.trailingAnchor.constraint(equalTo: trailingAnchor).isActive                      = true
        ImageCell.widthAnchor.constraint(equalToConstant: contentView.frame.width / 3.5).isActive  = true
        
        labelWord.topAnchor.constraint(equalTo: topAnchor).isActive                                = true
        labelWord.bottomAnchor.constraint(equalTo: bottomAnchor).isActive                          = true
        labelWord.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4).isActive           = true
        labelWord.trailingAnchor.constraint(equalTo: ImageCell.leadingAnchor).isActive             = true
        }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setContentCellWith(data: Translate) {
        
        DispatchQueue.main.async {
            guard let text = data.text, let word = data.wordForTranslate else { return }
            self.labelWord.text = "\(word) -> \(text)"
            let urlImage = data.imageUrl?.allObjects as! [ImageUrl]
            guard let firstImageUrl = urlImage.first else { return }
            guard let imagePath = firstImageUrl.imagePath else { return }
            self.ImageCell.loadImageUsingCacheWithURLString(imagePath, placeHolder: UIImage(named: "placeholder"))
            
        }
    }
}
