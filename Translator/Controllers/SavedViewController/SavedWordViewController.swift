//
//  SavedWordViewController.swift
//  Translator
//
//  Created by Алексей ]Чанов on 03/12/2019.
//  Copyright © 2019 Алексей Чанов. All rights reserved.
//

import UIKit
import CoreData

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
    
    lazy var fetchedhResultController: NSFetchedResultsController<NSFetchRequestResult> = {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: Translate.self))
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "wordForTranslate", ascending: true)]
        let frc = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataStack.sharedInstance.persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        frc.delegate = self
        return frc
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
        
//        if let photo = fetchedhResultController.object(at: indexPath) as? Photo {
//            cell.setPhotoCellWith(photo: photo)
//        }
        
        return cell
    }
    
    
    
}

extension SavedWordViewController: NSFetchedResultsControllerDelegate {
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            self.tableView.insertRows(at: [newIndexPath!], with: .automatic)
        case .delete:
            self.tableView.deleteRows(at: [indexPath!], with: .automatic)
        default:
            break
        }
    }
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.tableView.endUpdates()
    }
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
}
