//
//  String+Extension .swift
//  AlbumArtworks
//
//  Created by Roman Trekhlebov on 08.12.2020.
//

import UIKit

extension String {
    static  func atributedLblString(lhs: String, rhs: String, sizeMultiplayer: CGFloat = 1) -> NSAttributedString {

        let regularAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14 * sizeMultiplayer)]
        let largeAttributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14 * sizeMultiplayer)]

        let firstString = NSMutableAttributedString(string: lhs, attributes: largeAttributes)
        let separator = NSAttributedString(string: ": ", attributes: largeAttributes)
        let secondString = NSAttributedString(string: rhs, attributes: regularAttributes)

        firstString.append(separator)
        firstString.append(secondString)

        return firstString
    }
}
