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
    
    // MARK: - Private properties
    lazy private var tableView: UITableView = {
        var viewForTable = UITableView()
        viewForTable.delegate = self
        viewForTable.dataSource = self
        viewForTable.backgroundColor = .clear
        viewForTable.register(SavedTableViewCell.self, forCellReuseIdentifier: SavedTableViewCell.reuseId)
        viewForTable.translatesAutoresizingMaskIntoConstraints = false
        viewForTable.rowHeight = 100
        return viewForTable
    }()
    
    lazy private var fetchedhResultController: NSFetchedResultsController<NSFetchRequestResult> = {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: Translate.self))
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "wordForTranslate", ascending: true)]
        let frc = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataStack.sharedInstance.persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        frc.delegate = self
        return frc
    }()
    
    
    // MARK: - UIViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        performTableContent()
        
        self.view.addSubview(tableView)
        
        let margins = view.layoutMarginsGuide
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalToSystemSpacingBelow: margins.topAnchor, multiplier: 0),
            tableView.bottomAnchor.constraint(equalToSystemSpacingBelow: margins.bottomAnchor, multiplier: 0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -2),
            tableView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 0)])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableView.reloadData()
    }
    
    
    // MARK: - FetchedhResultController perform fetch
    private func performTableContent() {
        do {
            try self.fetchedhResultController.performFetch()
            print("COUNT FETCHED FIRST: \(self.fetchedhResultController.sections?[0].numberOfObjects ?? 0)")
        } catch let error  {
            print("ERROR: \(error)")
        }
    }
}


// MARK: - UITableViewDelegate & UITableViewDataSource
extension SavedWordViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = fetchedhResultController.sections?.first?.numberOfObjects {
            return count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SavedTableViewCell.reuseId, for: indexPath) as! SavedTableViewCell
        
        if let object = fetchedhResultController.object(at: indexPath) as? Translate {
            cell.setContentCellWith(data: object)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let animation = AnimationFactory.makeSlideIn(duration: 0.5, delayFactor: 0.05)
        let animator = Animator(animation: animation)
        animator.animate(cell: cell, at: indexPath, in: tableView)
    }
    
}

// MARK: - NSFetchedResultsControllerDelegate
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
