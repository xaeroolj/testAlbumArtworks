//
//  UIViewController+Extension .swift
//  AlbumArtworks
//
//  Created by Roman Trekhlebov on 07.12.2020.
//

import UIKit

extension UIViewController {

    func showAlert(title: String, message: String, actions: [UIAlertAction]? = nil ) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        if let actions = actions {
            actions.forEach { (action) in
                alert.addAction(action)
            }
        } else {
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"),
                                          style: .default, handler: nil))
        }
        self.present(alert, animated: true, completion: nil)

    }
}
