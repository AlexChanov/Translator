//
//  MainViewController.swift
//  Translator
//
//  Created by Алексей ]Чанов on 03/12/2019.
//  Copyright © 2019 Алексей Чанов. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView(style: .gray)
        activity.translatesAutoresizingMaskIntoConstraints = false
        return activity
    }()
    
    lazy var buttonLanguage: UIButton = {
        let button = UIButton.init(type: .roundedRect)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 20
        button.layer.shadowOffset = CGSize(width: 0, height: 5)
        button.layer.shadowOpacity = 0.5
        button.layer.shadowRadius = 5
        button.backgroundColor = UIColor.white
        button.setTitle("🇷🇺  ➔  🇺🇸", for:  .normal)
        button.titleLabel?.font =  UIFont.boldSystemFont(ofSize: 40)
        button.setTitleColor(UIColor.pureGreen, for: .normal)
        button.titleColor(for: )
        button.addTarget(self, action: #selector(buttonClicked(_ :)), for: .touchUpInside)
        return button
    }()
    
    lazy var translateText: UITextField = {
        var textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
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
    var translateValuewArray = [FinalResult]()
    {
        didSet{
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.activityIndicator.stopAnimating()
            }
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setupLayout()
    }
    
    @objc func buttonClicked(_ : UIButton) {
        print("Tap in button")
    }
    
    private func getTranslate(_ text: String, _ lang: String = "en") {
        networkService.translate(text, lang: lang) { (result, error) in
            guard let result = result else {return}
            self.addElementToArrayInReverseOrder(array: &self.translateValuewArray, newElement: result)
            self.presentView(result)
        }
    }
    
    // MARK: - Present child ViewController
    private func presentView(_ result: FinalResult) {
        let newTranslatedViewContriller = NewTranslatedWordViewController()
        newTranslatedViewContriller.dataForFilligCell = result
        newTranslatedViewContriller.wordforTranlate = self.wordsForTranslate.first ?? ""
       
        DispatchQueue.main.async {
            self.add(newTranslatedViewContriller, frame: CGRect(x: self.view.frame.minX, y: self.view.frame.minY-100, width: self.view.frame.width, height: self.view.frame.height*0.8))
            
        }
    }
    
     func addElementToArrayInReverseOrder<T>( array:inout [T],newElement: T) {
        let temproaryArray = array
        array.removeAll()
        array.append(newElement)
        array.append(contentsOf: temproaryArray)
    }
    
    
    // MARK: - Setup constraints
    private func setupLayout() {
        
        self.view.addSubview(activityIndicator)
        self.view.addSubview(buttonLanguage)
        self.view.addSubview(translateText)
        self.view.addSubview(tableView)
        
        let margins = view.layoutMarginsGuide
        NSLayoutConstraint.activate([
            buttonLanguage.topAnchor.constraint(equalTo: margins.topAnchor, constant: 0),
            buttonLanguage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -2),
            buttonLanguage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            buttonLanguage.heightAnchor.constraint(equalToConstant: 50),
            translateText.topAnchor.constraint(equalTo: buttonLanguage.bottomAnchor, constant: 50),
            translateText.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            translateText.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.width - 20),
            translateText.heightAnchor.constraint(equalToConstant: 50),
            tableView.topAnchor.constraint(equalToSystemSpacingBelow: translateText.bottomAnchor, multiplier: 0),
            tableView.bottomAnchor.constraint(equalToSystemSpacingBelow: margins.bottomAnchor, multiplier: 0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -2),
            tableView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 0),
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
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
        languageCell?.setDataforCell(data: translateValuewArray[indexPath.row], wordforTranlate: wordsForTranslate[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

    //MARK: - TextField Delegate
extension MainViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        guard let text = textField.text else {return true}
        
        addElementToArrayInReverseOrder(array: &wordsForTranslate, newElement: text)
        getTranslate(text)
        textField.text = ""
        activityIndicator.startAnimating()
        
        return true
    }
}
