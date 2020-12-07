//
//  MainView.swift
//  AlbumArtworks
//
//  Created by Roman Trekhlebov on 03.12.2020.
//

import UIKit

final class MainView: UIView {

    // MARK: - Public Properties
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        layout.itemSize = CGSize.zero
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 13.0, *) {
            collectionView.backgroundColor = .systemBackground
        } else {
            collectionView.backgroundColor = .white
        }
        return collectionView
    }()
    // MARK: - Private Properties
    private var collViewBottomConstraint: NSLayoutConstraint!

    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }

    // MARK: - Lifecycle
    /*
     A Boolean value that indicates whether
     the receiver depends on the constraint-based layout system.
     https://developer.apple.com/documentation/uikit/uiview/1622549-requiresconstraintbasedlayout
     */
    override class var requiresConstraintBasedLayout: Bool {
        return true
    }
    // MARK: - Public Methods
    public func setBottomConstraint(to constant: CGFloat) {
        collViewBottomConstraint.constant = -constant
    }
    public func updateBackground(with message: String?) {

        guard let message = message else {
            collectionView.backgroundView  = nil
            return
        }

        let backgroundLbl: UILabel  = UILabel(frame: CGRect(x: 0, y: 0,
                                                            width: collectionView.bounds.size.width,
                                                            height: collectionView.bounds.size.height))
        backgroundLbl.text = message
        if #available(iOS 13.0, *) {
            backgroundLbl.textColor = UIColor.label
        } else {
            backgroundLbl.textColor = UIColor.black
        }
        backgroundLbl.textAlignment = .center
        backgroundLbl.numberOfLines = 0
        collectionView.backgroundView  = backgroundLbl
    }

    // MARK: - Private Methods
    private func setupView() {
        backgroundColor = .white
        addSubview(collectionView)
        setupLayout()
    }
    private func setupLayout() {
        collViewBottomConstraint = collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collViewBottomConstraint
        ])
    }
}
