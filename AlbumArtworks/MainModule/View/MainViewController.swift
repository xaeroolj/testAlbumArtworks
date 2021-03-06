//
//  ViewController.swift
//  AlbumArtworks
//
//  Created by Roman Trekhlebov on 03.12.2020.
//

import UIKit
import Nuke

protocol MainViewProtocol: AnyObject {
    func viewLoad()
    func updateView()
    func loading()
    func showError(_ error: NetworkError)
}

final class MainViewController: UIViewController, ViewSpecificController {
    typealias RootView = MainView

    // MARK: - Public Properties
    var presenter: MainViewPresenterProtocol!
    var searchController: UISearchController!

    // MARK: - Private Properties
    private var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    // MARK: - Lifecycle
    override func loadView() {
        self.view = MainView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = NSLocalizedString(LocStrings.Main.mainTitle,
                                       comment: "")

        view().collectionView.delegate = self
        view().collectionView.dataSource = self
        view().collectionView.register(MainCell.self,
                                       forCellWithReuseIdentifier: Constants.CellIdentifiers.mainModuleCell)

        setupSearchController()
        setupNotification()
        viewLoad()
        setupUI()
        setupNuke()

    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromAllNotifications()
    }

    // MARK: - Private Methods
    private func setupUI() {
        self.hideKeyboardWhenTappedAround()
    }

    private func setupNuke() {
        let contentModes = ImageLoadingOptions.ContentModes(
            success: .scaleAspectFill,
            failure: .scaleAspectFit,
            placeholder: .scaleAspectFit)

        ImageLoadingOptions.shared.contentModes = contentModes
        ImageLoadingOptions.shared.placeholder = UIImage(named: "appleSJM")
        ImageLoadingOptions.shared.failureImage = UIImage(named: "appleSJM")
        ImageLoadingOptions.shared.transition = .fadeIn(duration: 0.5)
    }

    private func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view().addGestureRecognizer(tap)
    }

    @objc private func dismissKeyboard() {
        searchController.searchBar.resignFirstResponder()
    }

    private func setupSearchController() {

        searchController = UISearchController(searchResultsController: nil)
        searchController.delegate = self
        searchController.searchResultsUpdater = self

        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.autocapitalizationType = .none
        searchController.searchBar.placeholder = NSLocalizedString(LocStrings.Main.searchPlaceholder, comment: "")

        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false

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

    private func searchContentForSearchText(_ searchText: String) {

        print("Serch Text: \(searchText)")

        presenter.getAlbums(for: searchText)

    }
}

// MARK: - MainViewProtocol
extension MainViewController: MainViewProtocol {
    func viewLoad() {
        print("main presenter call view load")
        view().collectionView.reloadData()
        let localizedString = NSLocalizedString(LocStrings.Main.intState,
                                                comment: "")
        view().updateBackground(with: NSLocalizedString(localizedString, comment: ""))
    }

    func loading() {
        print("main presenter call loading")
        view().collectionView.reloadData()
        let localizedString = NSLocalizedString(LocStrings.Main.loadingState,
                                               comment: "")
        view().updateBackground(with: localizedString)
    }

    func updateView() {
        print("main presenter call updateView")
        view().collectionView.reloadData()
        view().updateBackground(with: nil)
    }

    func showError(_ error: NetworkError) {
        if error == .domainError {
            let localizedActionString = NSLocalizedString(LocStrings.Err.againAction,
                                                          comment: "")
            let localizedTitle = NSLocalizedString(LocStrings.Err.againAction,
                                                   comment: "")
            var actionArray = [UIAlertAction]()

            let reloadAlert = UIAlertAction(title: localizedActionString, style: .default) { (_) in

                self.presenter.reloadData()
            }

            actionArray.append(reloadAlert)

        self.showAlert(title: localizedTitle,
                       message: error.localizedDescription,
                       actions: actionArray)
        } else {
            view().collectionView.reloadData()
            view().updateBackground(with: error.localizedDescription)
        }
    }
}

// MARK: - UISearchBarDelegate
extension MainViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

// MARK: - UISearchResultsUpdating
extension MainViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {

        let searchBar = searchController.searchBar
        guard let searchString = searchBar.text else {return}
        searchContentForSearchText(searchString)
    }
}

// MARK: - UISearchControllerDelegate
extension MainViewController: UISearchControllerDelegate {
    //stub
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate
extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let inset: CGFloat = 20
        let column: CGFloat = 2
        let width  = (view.frame.width - (inset * (column + 1))) / column
        return CGSize(width: width, height: width)
    }

    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return presenter.albumsArray?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: Constants.CellIdentifiers.mainModuleCell,
                for: indexPath) as? MainCell,
              let album = presenter.albumsArray?[indexPath.row] else { return UICollectionViewCell() }

        cell.nameLabel.text = album.albumName

        if let urlString = album.artworkUrl,
           let url = URL(string: urlString) {

            let request = ImageRequest(
                url: url)

            Nuke.loadImage(with: request, into: cell.albumImage)
        }

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        guard let album = presenter.albumsArray?[indexPath.row] else { return }
        presenter.tapOnAlbum(album: album)
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
