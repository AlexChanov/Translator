//
//  NewTranslatedWordViewController.swift
//  Translator
//
//  Created by Алексей ]Чанов on 07/12/2019.
//  Copyright © 2019 Алексей Чанов. All rights reserved.
//

import UIKit
import CoreData

class NewTranslatedWordViewController: UIViewController {
    
    // MARK: - IBOutlet
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var saveTextLabel: UILabel!
    
    // MARK: - Action
    @IBAction func dismissButton(_ sender: Any) {
        navigationController?.isNavigationBarHidden = false
        remove()
    }
    
    @IBAction func saveButton(_ sender: Any) {
        showNotificationText()
        saveData()
    }
    
    // MARK: - Public Properties
    var dataForFilligCell: FinalResult?
    var wordforTranlate = ""
    
    // MARK: - UIViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
   
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(NewTranslatedWordCollectionViewCell.self,
                                forCellWithReuseIdentifier: NewTranslatedWordCollectionViewCell.reuseId)
        
        guard let data = dataForFilligCell  else { return }
        setDataforCell(data: data, wordforTranlate: wordforTranlate)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.isNavigationBarHidden = true
        tabBarController?.tabBar.isHidden = true        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        tabBarController?.tabBar.isHidden = false

    }
    
    
    // MARK: - Init properties
    func setDataforCell(data: FinalResult, wordforTranlate: String) {
        dataForFilligCell = data
        guard let translated = data.tranlationResult.text.first else { return }
        guard textLabel != nil, textLabel.text != nil else { return }
        textLabel.text = "\(wordforTranlate) - \(translated)"
    }
    
    // MARK: - Save in CoreData
    private func saveData() {
        guard let dataForFilligCell = dataForFilligCell else { return }
        guard let wordWhichWasTranslated = dataForFilligCell.tranlationResult.text.first else { return }
        
        let saveInfo = Storage.saveTranslateInfo(wordForTranslate: wordforTranlate, translatedWord: wordWhichWasTranslated)
        for value in dataForFilligCell.image {
            let saveImage = Storage.saveImage(value.urls.small)
            saveImage.translate = saveInfo
        }
        CoreDataStack.sharedInstance.saveContext()
    }
    
    private func showNotificationText() {
        saveTextLabel.alpha = 1.0
        UIView.animate(withDuration: 1.0,
                       delay: 0,
                       options: .curveLinear,
                       animations: { self.saveTextLabel.alpha = .leastNonzeroMagnitude },
                       completion: {_ in
                        self.saveTextLabel.text = ""
        })
    }
}

    //MARK: - CollectionView DataSource and Delegate
extension NewTranslatedWordViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let arrayValue = dataForFilligCell else {return 0}
        return arrayValue.image.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewTranslatedWordCollectionViewCell.reuseId, for: indexPath) as! NewTranslatedWordCollectionViewCell
        
        guard let dataForCell = dataForFilligCell else { return cell }
        cell.setPhotoInCell(photo: dataForCell.image[indexPath.row])
        return cell
    }
  }

    //MARK: - UICollectionViewDelegateFlowLayout
extension NewTranslatedWordViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let sizeCell = CGSize(width: self.view.frame.width/2, height: self.view.frame.width/2)
        return sizeCell
    }
}
