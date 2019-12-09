//
//  BaseTabBarController.swift
//  Translator
//
//  Created by Алексей ]Чанов on 03/12/2019.
//  Copyright © 2019 Алексей Чанов. All rights reserved.
//

import UIKit

class BaseTabBarController: CustomTabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewControllers = [
            createNewNavController(viewController: MainViewController(), title: "Translate", imageName: "general"),
            createNewNavController(viewController: SavedWordViewController(), title: "Saved", imageName: "account")
            //            createNewNavController(viewController: ChatsTableViewController(), title: "Chats", imageName: "chats"),
            //            createNewNavController(viewController: StatisticsVC(), title: "Statistics", imageName: "statistics"),
            //            createNewNavController(viewController: LimitsAndGoalsVC(), title: "Goals", imageName: "goal")
        ]
        
    }
    
    fileprivate func createNewNavController(viewController: UIViewController, title: String, imageName: String) -> UIViewController {
        let navController = UINavigationController(rootViewController: viewController)
        
        viewController.navigationItem.title = title
        
        navController.navigationBar.prefersLargeTitles = true
        navController.view.backgroundColor = .white
        navController.tabBarItem.title = title
        navController.tabBarItem.image = UIImage(named: imageName)?.withRenderingMode(.alwaysOriginal)
        
        return navController
    }
    
}
