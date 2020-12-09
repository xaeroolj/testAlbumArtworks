//
//  DetailViewController.swift
//  AlbumArtworks
//
//  Created by Roman Trekhlebov on 07.12.2020.
//

import UIKit
import Nuke

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
        view().tableView.delegate = self
        view().tableView.dataSource = self
        presenter.initData()
        setupNuke()
    }
    // MARK: - Public Methods
    // MARK: - Private Methods
    private func setupNuke() {
        guard let imageString = presenter.album?.artworkUrl,
              let url = URL(string: imageString)else { return }
        view().albumImage.image = ImageLoadingOptions.shared.placeholder

        ImagePipeline.shared.loadImage(
            with: url) { [weak self] response in
            guard let self = self else {
                return
            }
            switch response {
            case .failure:
                self.view().albumImage.image = ImageLoadingOptions.shared.failureImage
                self.view().albumImage.contentMode = .scaleAspectFit

            case let .success(imageResponse):
                self.view().albumImage.image = imageResponse.image
                self.view().albumImage.contentMode = .scaleAspectFill
            }
        }
    }
}

extension DetailViewController: DetailViewProtocol {
    func viewLoad() {
        print("presenter viewLoad")
        guard let album = presenter.album else { return }
        self.title = "\(album.albumId)"
        view().setInitUI(album)
        view().tableView.setBackgroundLbl(with: nil)
    }
    func updateView() {
        print("presenter updateView")
        view().activityIndicator.stopAnimating()
        view().tableView.setBackgroundLbl(with: nil)
        view().tableView.reloadData()
    }
    func loading() {
        print("presenter loading")
        view().activityIndicator.startAnimating()
    }
    func showError(_ error: NetworkError) {
        print("Error: \(error)")
        view().activityIndicator.stopAnimating()
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
            view().tableView.reloadData()
            view().tableView.setBackgroundLbl(with: error.localizedDescription)
        }
    }
}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.album?.tracks?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        var cell: UITableViewCell? = tableView.dequeueReusableCell(withIdentifier:
                                                                    Constants.CellIdentifiers.detailModuleCell)
        if cell == nil {
            cell = UITableViewCell(style: .subtitle,
                                   reuseIdentifier: Constants.CellIdentifiers.detailModuleCell)
        }
        let track = presenter.album?.tracks![indexPath.row]

        let artistString = NSLocalizedString(LocStrings.Detail.artist, comment: "")
        let trackString = NSLocalizedString(LocStrings.Detail.track, comment: "")

        cell?.detailTextLabel?.attributedText = String.atributedLblString(lhs: artistString,
                                                                          rhs: track!.artist)
        cell?.detailTextLabel?.numberOfLines = 0
        cell!.textLabel!.attributedText = String.atributedLblString(lhs: trackString,
                                                                    rhs: track!.trackName)
        cell?.textLabel?.numberOfLines = 0
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

}
