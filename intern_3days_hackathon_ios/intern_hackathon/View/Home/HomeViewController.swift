//
//  HomeViewController.swift
//  intern_hackathon
//
//  Created by 神野成紀 on 2020/08/12.
//  Copyright © 2020 caraquri. All rights reserved.
//

import UIKit

final class HomeViewController: UIViewController {
    
    @IBOutlet private weak var eventsList: UITableView!
    @IBOutlet private weak var eventSearchBar: UISearchBar!
    var events: [Event] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        eventsList.register(R.nib.homeViewCell)
        searchEvents()
    }
    
    private func searchEvents() {
        APIClient.fetchEvents(keyword: "", viewDidLoad: true) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let event):
                    self.events.append(contentsOf: event)
                    self.eventsList.reloadData()
                case .failure(let error):
                    let alert = UIAlertController.createErrorAlert(error)
                    self.present(alert, animated: true)
                }
            }
        }
    }
}
//MARK: - UITableViewDelegate
extension HomeViewController: UITableViewDelegate {
    
}
//MARK: - UITableViewDataSource
extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.homeViewCell, for: indexPath)!
        cell.set(event: events[indexPath.row])
        return cell
    }
}
