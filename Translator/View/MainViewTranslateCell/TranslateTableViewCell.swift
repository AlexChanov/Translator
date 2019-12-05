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
    func setDataforCell(data: FinalResult, wordforTranlate: String)
    
    
}

class TranslateTableViewCell: UITableViewCell, LanguageCellProtocol {

    
    
    @IBOutlet weak var translateDirectionLabel: UILabel!
    @IBOutlet weak var wordForTranslateLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        shapeLayer = CAShapeLayer()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CollectionViewCellForMainView.self, forCellWithReuseIdentifier: CollectionViewCellForMainView.reuseId)
        
        
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    
    
    func setDataforCell(data: FinalResult, wordforTranlate: String) {
        dataForFilligCell = data
        model = data.tranlationResult.text.first
        self.wordForTranslate = wordforTranlate
    }
    
   private var dataForFilligCell: FinalResult?
    
    internal var model: String? {
        didSet {
            translateDirectionLabel.text = model
            accessibilityLabel = model
        }
    }
    
    internal var wordForTranslate : String? {
        didSet{
            wordForTranslateLabel.text = wordForTranslate
            accessibilityLabel = wordForTranslate
        }
    }
    // доделать
   private var shapeLayer: CAShapeLayer! {
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



// MARK: - UICollectionViewDelegate & UICollectionViewDataSource

extension TranslateTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let arrayValue = dataForFilligCell else {return 0}
        return arrayValue.image.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellForMainView.reuseId, for: indexPath) as! CollectionViewCellForMainView

//        cell.imageView.image = 
        
        return cell
    }
}

extension TranslateTableViewCell : UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let sizeCell = CGSize(width: UIScreen.main.bounds.width/3, height: UIScreen.main.bounds.width/3)
        
        return sizeCell
    }
    
}
