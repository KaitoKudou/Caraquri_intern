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
    var searchingText = ""
    
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
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let targetCell = presenter.events.count - indexPath.row
        if presenter.events.count >= 20 && targetCell == 5 && presenter.APIItemCount == 20 {
            presenter.searchEvents(viewDidLoad: false, keyword: searchingText)
        }
    }
}
//MARK: - UISearchBarDelegate
extension HomeViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text, !searchBar.text!.isEmpty else {
            return
        }
        searchingText = text
        print(text)
        presenter.refresh()
        presenter.searchEvents(viewDidLoad: false, keyword: text)
        searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false) { _ in
            print(searchText)
            self.presenter.refresh()
            self.presenter.searchEvents(viewDidLoad: false, keyword: searchText)
        }
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
