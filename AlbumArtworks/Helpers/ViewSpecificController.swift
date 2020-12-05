//
//  ViewSpecificController.swift
//  AlbumArtworks
//
//  Created by Roman Trekhlebov on 05.12.2020.
//

import UIKit

protocol ViewSpecificController {
    associatedtype RootView: UIView
}
extension ViewSpecificController where Self: UIViewController {
    func view() -> RootView {
        return self.view as? RootView ?? RootView()
    }
}
