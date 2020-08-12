//
//  HomeViewController.swift
//  intern_hackathon
//
//  Created by 神野成紀 on 2020/08/12.
//  Copyright © 2020 caraquri. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
}
//MARK: -
extension HomeViewController: UITableViewDelegate {
    
}
//MARK: -
extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
