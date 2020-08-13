//
//  HomeViewPresenter.swift
//  intern_hackathon
//
//  Created by 神野成紀 on 2020/08/13.
//  Copyright © 2020 caraquri. All rights reserved.
//
import Firebase
import Foundation

class HomeViewPresenter {
    var events: [Event] = []
    private let view: HomeViewProtocol!
    
    init(view: HomeViewProtocol) {
        self.view = view
    }
    
    func searchEvents(viewDidLoad: Bool, keyword: String) {
        refresh()
        APIClient.fetchEvents(keyword: keyword, viewDidLoad: viewDidLoad) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let event):
                    self.events.append(contentsOf: event)
                    self.view.reloadData()
                case .failure(let error):
                    self.view.presentAlert(error: error)
                }
            }
        }
    }
    
    private func refresh() {
        events.removeAll()
    }
}
