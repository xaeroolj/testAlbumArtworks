//
//  DetailView.swift
//  AlbumArtworks
//
//  Created by Roman Trekhlebov on 07.12.2020.
//

import UIKit

final class DetailView: UIView {
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }

    // MARK: - Private Methods
    private func setupView() {
        backgroundColor = .white
    }
}
