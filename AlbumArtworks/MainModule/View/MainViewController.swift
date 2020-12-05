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

final class MainViewController: UIViewController, ViewSpecificController {
    typealias RootView = MainView

    // MARK: - IBOutlets
    // MARK: - Public Properties
    var presenter: MainViewPresenterProtocol!
    var searchController: UISearchController!

    // MARK: - Private Properties
    private var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    // MARK: - Initializers
    // MARK: - Lifecycle

    override func loadView() {
        self.view = MainView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Title"

        view().collectionView.delegate = self
        view().collectionView.dataSource = self
        view().collectionView.register(UICollectionViewCell.self,
                                       forCellWithReuseIdentifier: Constants.CellIdentifiers.mainModuleCell)

        setupSearchController()
        setupNotification()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromAllNotifications()
    }

    // MARK: - Public Methods
    // MARK: - Private Methods

    private func setupSearchController() {

        searchController = UISearchController(searchResultsController: nil)
        searchController.delegate = self
        searchController.searchResultsUpdater = self

        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.autocapitalizationType = .none
        searchController.searchBar.placeholder = "Placeholder"

        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false

        enum Category: CaseIterable {
            case all, one, two
        }

        searchController.searchBar.scopeButtonTitles = Category.allCases
            .map { "\($0)" }
        searchController.searchBar.delegate = self

        //definesPresentationContext = true will hide search bar on next VC
        definesPresentationContext = true
    }

    private func setupNotification() {
        subscribeToNotification(UIResponder.keyboardWillShowNotification,
                                selector: #selector(keyboardWillShowOrHide))
        subscribeToNotification(UIResponder.keyboardWillHideNotification,
                                selector: #selector(keyboardWillShowOrHide))
    }

    private func searchContentForSearchText(_ searchText: String,
                                            category: String? = nil) {

        print("Serch Text: \(searchText), Category: \(category ?? "Not set")")

    }
}

// MARK: - MainViewProtocol
extension MainViewController: MainViewProtocol {
    func viewLoad() {
    }
    func updateView() {
    }
    func showError() {
    }
}

// MARK: - UISearchBarDelegate
extension MainViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }

    func searchBar(_ searchBar: UISearchBar,
                   selectedScopeButtonIndexDidChange selectedScope: Int) {
        let category = searchBar.scopeButtonTitles![selectedScope]
        print("Select cattegory: \(category)")
        searchContentForSearchText(searchBar.text!, category: category)
    }
}

// MARK: - UISearchResultsUpdating
extension MainViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        //UISearchResultsUpdating will inform your class of any text changes within the UISearchBar.
        let searchBar = searchController.searchBar
        let category = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]

        searchContentForSearchText(searchBar.text!, category: category)
    }
}

// MARK: - UISearchControllerDelegate
extension MainViewController: UISearchControllerDelegate {

}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate
extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return 200
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.CellIdentifiers.mainModuleCell,
                                                        for: indexPath)
        myCell.backgroundColor = UIColor.red
        return myCell
    }
}

// MARK: - NotificationCenter
extension MainViewController {
    private func subscribeToNotification(_ notification: NSNotification.Name, selector: Selector) {
        NotificationCenter.default.addObserver(self, selector: selector, name: notification, object: nil)
    }

    private func unsubscribeFromAllNotifications() {
        NotificationCenter.default.removeObserver(self)
    }

    @objc private func keyboardWillShowOrHide(notification: NSNotification) {

        print("keyboardWillShowOrHide")
        guard notification.name == UIResponder.keyboardWillShowNotification else {
            print("Reset view")
            view().setBottomConstraint(to: 0)
            view.layoutIfNeeded()
            return
        }
        guard
            let info = notification.userInfo,
            let keyboardFrame = info[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue
        else {
            return
        }
        let keyboardHeight = keyboardFrame.cgRectValue.size.height + 20
        UIView.animate(withDuration: 0.1, animations: { [unowned self] () -> Void in
            self.view().setBottomConstraint(to: keyboardHeight)
            self.view.layoutIfNeeded()
        })
    }
}
