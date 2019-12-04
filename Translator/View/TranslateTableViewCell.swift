//
//  TranslateTableViewCell.swift
//  Translator
//
//  Created by Алексей ]Чанов on 03/12/2019.
//  Copyright © 2019 Алексей Чанов. All rights reserved.
//

import UIKit

import UIKit

protocol LanguageCellProtocol: class {
    /// set model for prepare UI
    var model: String? { get set }
    var wordForTranslate: String? { get set }
    
    
}

class TranslateTableViewCell: UITableViewCell, LanguageCellProtocol {
    
    @IBOutlet weak var translateDirectionLabel: UILabel!
    @IBOutlet weak var wordForTranslateLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //доделать
        shapeLayer = CAShapeLayer()
        
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    var model: String? {
        didSet {
            translateDirectionLabel.text = model
            accessibilityLabel = model
        }
    }
    
    var wordForTranslate : String? {
        didSet{
            wordForTranslateLabel.text = wordForTranslate
            accessibilityLabel = wordForTranslate
        }
    }
    // доделать
    var shapeLayer: CAShapeLayer! {
        didSet{
            shapeLayer.lineWidth = 5
            shapeLayer.lineCap = .round
            shapeLayer.fillColor = nil
            shapeLayer.strokeEnd = 1
            let color = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1).cgColor
            shapeLayer.strokeColor = color
            
        }
    }
    
    
}
