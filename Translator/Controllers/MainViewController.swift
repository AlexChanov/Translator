//
//  MainViewController.swift
//  Translator
//
//  Created by Алексей ]Чанов on 03/12/2019.
//  Copyright © 2019 Алексей Чанов. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    lazy var buttonLanguage: UIButton = {
        let button = UIButton.init(type: .roundedRect)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 20
        button.layer.shadowOffset = CGSize(width: 0, height: 5)
        button.layer.shadowOpacity = 0.5
        button.layer.shadowRadius = 5
        button.backgroundColor = UIColor.white
        button.setTitle("Выберите язык", for:  .normal)
        button.addTarget(self, action: #selector(buttonClicked(_ :)), for: .touchUpInside)
        return button
    }()
    
   lazy var translateText: UITextField = {
        var textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
              textField.backgroundColor = .yellow
              textField.borderStyle = .bezel
              textField.keyboardAppearance = .light
              textField.placeholder = "Введите слово для перевода"
              textField.delegate = self
        return textField
    }()
    
    lazy var tableView: UITableView = {
           var viewForTable = UITableView()
           viewForTable.delegate = self
           viewForTable.dataSource = self
           viewForTable.backgroundColor = .clear
           viewForTable.register(tableViewCellNiB, forCellReuseIdentifier: reusableCellIdentifier)
           viewForTable.translatesAutoresizingMaskIntoConstraints = false
           viewForTable.rowHeight = 200
           return viewForTable
       }()
    
    let networkService = TranslateNetworkService()
    var wordsForTranslate = [String]()
    var translateValuewArray = [TranslationResult]()
    {
        didSet{
            print(translateValuewArray.last?.text.first)
            DispatchQueue.main.async {
                          self.tableView.reloadData()
                      }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setupLayout()
    }
    
    @objc func buttonClicked(_ : UIButton) {
        print("Tap in button")
    }
    
    
    
    private func getTranslate(_ text: String, _ lang: String) {
        networkService.translate(text, lang: lang) { (result, error) in
            guard let result = result else {return}
            self.addElementToArrayInReverseOrder(array: &self.translateValuewArray, newElement: result)
        }
    }
    
    private func addElementToArrayInReverseOrder<T>( array:inout [T],newElement: T) {
        let temproaryArray = array
        array.removeAll()
        array.append(newElement)
        array.append(contentsOf: temproaryArray)
    }
    
    
    // MARK: - Setup constraints
    private func setupLayout() {
        
        self.view.addSubview(buttonLanguage)
        self.view.addSubview(translateText)
        self.view.addSubview(tableView)
        
        let margins = view.layoutMarginsGuide
        NSLayoutConstraint.activate([
            buttonLanguage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonLanguage.topAnchor.constraint(equalTo: margins.topAnchor, constant: 0),
            buttonLanguage.trailingAnchor.constraint(equalToSystemSpacingAfter: view.trailingAnchor, multiplier: -2),
            buttonLanguage.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 0),
            buttonLanguage.heightAnchor.constraint(equalToConstant: 50),
            translateText.topAnchor.constraint(equalTo: buttonLanguage.bottomAnchor, constant: 50),
            translateText.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            translateText.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.width - 20),
            translateText.heightAnchor.constraint(equalToConstant: 50),
            tableView.topAnchor.constraint(equalToSystemSpacingBelow: translateText.bottomAnchor, multiplier: 0),
            tableView.bottomAnchor.constraint(equalToSystemSpacingBelow: margins.bottomAnchor, multiplier: 0),
            tableView.trailingAnchor.constraint(equalToSystemSpacingAfter: view.trailingAnchor, multiplier: -2),
            tableView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 0)

            
        ])
    }
    
}
//MARK: - TableView DataSource and Delegate

extension MainViewController : UITableViewDataSource, UITableViewDelegate {
    
    private var tableViewCellNiB : UINib {
        return UINib(nibName: "TranslateTableViewCell", bundle: nil)
    }
    
    private var reusableCellIdentifier : String {
        return "reusableCellIdentifier"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return translateValuewArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: reusableCellIdentifier, for: indexPath)
        let languageCell = cell as? LanguageCellProtocol
        
        languageCell?.model = translateValuewArray[indexPath.row].text.first
        languageCell?.wordForTranslate = wordsForTranslate[indexPath.row]
        return cell
    }
    
}

//MARK: - TextField Delegate

extension MainViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        guard let text = textField.text else {return true}
        
        addElementToArrayInReverseOrder(array: &wordsForTranslate, newElement: text)
        getTranslate(text, "en")
        textField.text = ""
        
        
        print(wordsForTranslate)
        return true
    }
}
