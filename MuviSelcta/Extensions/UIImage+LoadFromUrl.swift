//
//  UIImage+LoadFromUrl.swift
//  Beerz
//
//  Created by Connor Jones on 02/02/2023.
//

import Foundation
import UIKit

/// Helpers to create and manage UIImages from images stored remotely
extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self?.image = image
                }
            }
        }
    }
}

extension UIImage {
    static func load(url: URL) -> UIImage {
        var result = UIImage()
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    result = image
                }
            }
        }

        return result
    }
}
