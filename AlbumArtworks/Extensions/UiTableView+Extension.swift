//
//  UiTableView+Extension.swift
//  AlbumArtworks
//
//  Created by Roman Trekhlebov on 08.12.2020.
//

import UIKit

extension UITableView {
    public func setBackgroundLbl(with message: String?) {

        guard let message = message else {
            self.backgroundView  = nil
            return
        }

        let backgroundLbl: UILabel  = UILabel(frame: CGRect(x: 0, y: 0,
                                                            width: self.bounds.size.width,
                                                            height: self.bounds.size.height))
        backgroundLbl.text = message
        if #available(iOS 13.0, *) {
            backgroundLbl.textColor = UIColor.label
        } else {
            backgroundLbl.textColor = UIColor.black
        }
        backgroundLbl.textAlignment = .center
        backgroundLbl.numberOfLines = 0
        self.backgroundView  = backgroundLbl
    }
}
