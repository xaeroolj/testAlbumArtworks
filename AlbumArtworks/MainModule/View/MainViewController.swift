//
//  ViewController.swift
//  AlbumArtworks
//
//  Created by Roman Trekhlebov on 03.12.2020.
//

import UIKit

protocol MainViewProtocol: AnyObject {
    func viewLoad()
    func updateView()
    func showError()
}

final class MainViewController: UIViewController {

    // MARK: - IBOutlets
    // MARK: - Public Properties
    var presenter: MainViewPresenterProtocol!

    // MARK: - Private Properties
    // MARK: - Initializers
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    // MARK: - Public Methods
    // MARK: - Private Methods
    // MARK: - IBActions
}

extension MainViewController: MainViewProtocol {
    func viewLoad() {
    }
    func updateView() {
    }
    func showError() {
    }
}
