//
//  UITableView+RegisterNib.swift
//  Beerz
//
//  Created by Connor Jones on 02/02/2023.
//

import Foundation
import UIKit

/// Helper to register table view cell nib
extension UITableView {
    func registerTableViewCell(cellName: String) {
        self.register(UINib(nibName: cellName, bundle: nil), forCellReuseIdentifier: cellName)
    }
}
