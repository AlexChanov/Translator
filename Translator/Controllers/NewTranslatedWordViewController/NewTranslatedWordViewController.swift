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
    
    // MARK: - Action
    @IBAction func dismissButton(_ sender: Any) {
        navigationController?.isNavigationBarHidden = false
        remove()
    }
    
    // MARK: - Save in CoreData
    @IBAction func saveButton(_ sender: Any) {

        guard let dataForFilligCell = dataForFilligCell else { return }
        guard let wordWhichWasTranslated = dataForFilligCell.tranlationResult.text.first else { return }

        let saveInfo = Storage.saveTranslateInfo(wordForTranslate: wordforTranlate, translatedWord: wordWhichWasTranslated)
        
        for value in dataForFilligCell.image {
        let saveImage = Storage.saveImage(value.urls.small)
        saveImage.translate = saveInfo
        }
        CoreDataStack.sharedInstance.saveContext()
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
    private func setDataforCell(data: FinalResult, wordforTranlate: String) {
        dataForFilligCell = data
        guard let translated = data.tranlationResult.text.first else { return }
        textLabel.text = "\(wordforTranlate) - \(translated)"
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

 // MARK: - CoreData
extension NewTranslatedWordViewController {
    
    
   
    private func createTranslateEntityFrom(url: String) -> NSManagedObject? {
        let context = CoreDataStack.sharedInstance.persistentContainer.viewContext
        if let translateEntity = NSEntityDescription.insertNewObject(forEntityName: "Translate", into: context) as? Translate {
            translateEntity.imagePath = url
            return translateEntity
        }
        return nil
    }
    
    private func saveInCoreDataWith(array: [String]) {
        _ = array.map{self.createTranslateEntityFrom(url: $0)}
        do {
            try CoreDataStack.sharedInstance.persistentContainer.viewContext.save()
        } catch let error {
            print(error)
        }
    }
    
    
    
}

