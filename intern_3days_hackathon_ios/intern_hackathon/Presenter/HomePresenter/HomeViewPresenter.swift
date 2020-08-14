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
    var events: [HomeViewCellData] = []
    var APIItemCount = 1
    var searchStart = 1
    private let view: HomeViewProtocol!
    let model: HomeViewModel!
    
    init(view: HomeViewProtocol) {
        self.view = view
        self.model = HomeViewModel()
    }
    
    func searchEvents(viewDidLoad: Bool, keyword: String) {
        APIClient.fetchEvents(keyword: keyword, viewDidLoad: viewDidLoad, startCount: searchStart) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let event):
                    event.forEach { (event) in
                        self.events.append(HomeViewCellData(event: event, color: false))
                    }
                    self.APIItemCount = event.count
                    self.searchStart += event.count
                    self.view.reloadData()
                case .failure(let error):
                    self.view.presentAlert(error: error)
                }
            }
        }
    }
    
    func refresh() {
        events.removeAll()
        APIItemCount = 1
        searchStart = 1
    }
    
    func setUserDefault(indexPath: IndexPath) {
        if UserDefaults.standard.string(forKey: events[indexPath.row].event.eventURL) == nil {
            UserDefaults.standard.set(events[indexPath.row].event.title, forKey: events[indexPath.row].event.eventURL)
            UserDefaults.standard.set(model.createDoucumentsID(), forKey: "\(events[indexPath.row].event.eventURL + "document")")
            model.sendBookmarkData(event: events[indexPath.row].event)
            view.reloadRows(indexPath: indexPath)
            if UserDefaults.standard.string(forKey: events[indexPath.row].event.eventURL) != nil {
                print("exist.")
            }
        } else {
            model.deleteBookmarkData(event: events[indexPath.row].event) { (event) in
                UserDefaults.standard.removeObject(forKey: event.eventURL)
                UserDefaults.standard.removeObject(forKey: "\(event.eventURL + "document")")
                self.view.reloadRows(indexPath: indexPath)
            }
            if UserDefaults.standard.string(forKey: events[indexPath.row].event.eventURL) == nil {
                print("deleted")
            }
        }
    }
    
    func createUsers() {
        let ID = model.createID()
        model.sendUserID(userID: ID)
        UserDefaults.standard.set(ID, forKey: "User")
    }
}
