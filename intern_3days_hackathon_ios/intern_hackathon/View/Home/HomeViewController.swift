//
//  HomeViewController.swift
//  intern_hackathon
//
//  Created by 神野成紀 on 2020/08/12.
//  Copyright © 2020 caraquri. All rights reserved.
//

import UIKit
import SafariServices

protocol HomeViewProtocol {
    func reloadData()
    func presentAlert(error: ErrorType)
}
final class HomeViewController: UIViewController {
    
    @IBOutlet private weak var eventsList: UITableView!
    @IBOutlet private weak var eventSearchBar: UISearchBar!
    var presenter: HomeViewPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = HomeViewPresenter(view: self)
        eventsList.register(R.nib.homeViewCell)
        presenter.searchEvents(viewDidLoad: true, keyword: "")
    }
}
//MARK: - UITableViewDelegate
extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let urlString = presenter.events[safe: indexPath.row]?.eventURL,
            let url = URL(string: urlString) else { return }
        
        let safariViewController = SFSafariViewController(url: url)
        present(safariViewController, animated: true)
    }
}
//MARK: - UITableViewDataSource
extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.homeViewCell, for: indexPath)!
        cell.set(event: presenter.events[indexPath.row])
        return cell
    }
}
//MARK: - UISearchBarDelegate
extension HomeViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text, !searchBar.text!.isEmpty else {
            return
        }
        presenter.searchEvents(viewDidLoad: false, keyword: text)
        searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
}

//MARK: - HomeViewProtocol
extension HomeViewController: HomeViewProtocol {
    func presentAlert(error: ErrorType) {
        let alert = UIAlertController.createErrorAlert(error)
        self.present(alert, animated: true)
    }

    func reloadData() {
        eventsList.reloadData()
    }
}
