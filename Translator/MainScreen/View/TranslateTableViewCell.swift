//
//  TranslateTableViewCell.swift
//  Translator
//
//  Created by Алексей ]Чанов on 03/12/2019.
//  Copyright © 2019 Алексей Чанов. All rights reserved.
//


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
    
    
    func setDataforCell(data: FinalResult, wordforTranlate: String) {
        dataForFilligCell = data
        model = data.tranlationResult.text.first
        self.wordForTranslate = wordforTranlate
    }
    
    // MARK: - Private properties
    private var dataForFilligCell: FinalResult?
    {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
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
    
    private var shapeLayer: CAShapeLayer! {
        didSet{
            shapeLayer.lineWidth = 5
            shapeLayer.lineCap = .round
            shapeLayer.fillColor = nil
            shapeLayer.strokeEnd = 1
            let color = UIColor.pureGreen.cgColor
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
        
        if dataForFilligCell != nil {
            cell.setPhotoInCell(photo: dataForFilligCell?.image[indexPath.row])
        }
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension TranslateTableViewCell : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let sizeCell = CGSize(width: UIScreen.main.bounds.width/3, height: UIScreen.main.bounds.width/3)
        
        return sizeCell
    }
}
