//
//  Extension + UITableView.swift
//  Translator
//
//  Created by Алексей ]Чанов on 10/12/2019.
//  Copyright © 2019 Алексей Чанов. All rights reserved.
//

import UIKit

extension UITableView {
    func isLastVisibleCell(at indexPath: IndexPath) -> Bool {
        guard let lastIndexPath = indexPathsForVisibleRows?.last else {
            return false
        }
        return lastIndexPath == indexPath
    }
}
