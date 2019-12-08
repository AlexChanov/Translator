//
//  SavedWordViewController.swift
//  Translator
//
//  Created by Алексей ]Чанов on 03/12/2019.
//  Copyright © 2019 Алексей Чанов. All rights reserved.
//

import UIKit

final class SavedWordViewController: UIViewController {

    
    lazy var tableView: UITableView = {
        var viewForTable = UITableView()
        viewForTable.delegate = self
        viewForTable.dataSource = self
        viewForTable.backgroundColor = .clear
        viewForTable.register(SavedTableViewCell.self, forCellReuseIdentifier: SavedTableViewCell.reuseId)
        viewForTable.translatesAutoresizingMaskIntoConstraints = false
        viewForTable.rowHeight = 100
        return viewForTable
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(tableView)
        
        let margins = view.layoutMarginsGuide
        NSLayoutConstraint.activate([
        tableView.topAnchor.constraint(equalToSystemSpacingBelow: margins.topAnchor, multiplier: 0),
        tableView.bottomAnchor.constraint(equalToSystemSpacingBelow: margins.bottomAnchor, multiplier: 0),
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -2),
        tableView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 0)])
    }
}


extension SavedWordViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SavedTableViewCell.reuseId, for: indexPath)
        return cell
    }
    
    
    
}
