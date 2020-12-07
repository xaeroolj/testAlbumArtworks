//
//  DetailViewController.swift
//  AlbumArtworks
//
//  Created by Roman Trekhlebov on 07.12.2020.
//

import UIKit

protocol DetailViewProtocol: AnyObject {
    func viewLoad()
    func updateView()
    func loading()
    func showError(_ error: NetworkError)
}

final class DetailViewController: UIViewController, ViewSpecificController {
    typealias RootView = DetailView

    // MARK: - IBOutlets
    // MARK: - Public Properties
    var presenter: DetailViewPresenterProtocol!
    // MARK: - Private Properties
    // MARK: - Initializers
    // MARK: - Lifecycle

    override func loadView() {
        self.view = DetailView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Detail"

    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    // MARK: - Public Methods
    // MARK: - Private Methods
    // MARK: - IBActions
}

extension DetailViewController: DetailViewProtocol {
    func viewLoad() {

    }

    func updateView() {

    }

    func loading() {

    }

    func showError(_ error: NetworkError) {
    }
}
