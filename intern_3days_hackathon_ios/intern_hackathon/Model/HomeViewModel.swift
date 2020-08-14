//
//  CreateID.swift
//  intern_hackathon
//
//  Created by 神野成紀 on 2020/08/14.
//  Copyright © 2020 caraquri. All rights reserved.
//

import Foundation
import Firebase

class HomeViewModel {
    let db = Firestore.firestore()
    let user = UserDefaults.standard.string(forKey: "User")
    
    func createID() -> String {
        let randomString = "abcdefghijklmnopqrstuvwsyzABCDEFGHIJKLMNOPQRSTUVWSYZ0123456789"
        var id = ""
        for _ in 0..<16 {
            let stringElement = randomString.randomElement()
            id.append(stringElement!)
        }
        return id
    }
    
    func createDoucumentsID() -> String {
        let randomString = "abcdefghijklmnopqrstuvwsyzABCDEFGHIJKLMNOPQRSTUVWSYZ0123456789"
        var id = ""
        for _ in 0..<16 {
            let stringElement = randomString.randomElement()
            id.append(stringElement!)
        }
        return id
    }
    
    func sendUserID(userID: String) {
        db.collection("Users").document(userID).setData(["UserID": userID]) { (err) in
            if let err = err {
                print(err)
            } else {
                print("sending completed")
            }
        }
    }
    
    func sendBookmarkData(event: Event) {
        let documentID = UserDefaults.standard.string(forKey: "\(event.eventURL + "document")")
        db.collection("Users").document(user!).collection("Bookmark").document(documentID!).setData(["title": event.title, "place": (event.address ?? "") + (event.place ?? ""), "date": event.startedAt!, "url": event.eventURL]) { (err) in
            if let err = err {
                print(err)
            } else {
                print("complete Bookmark.")
            }
        }
    }
    
    func deleteBookmarkData(event: Event, completion: @escaping(Event) -> Void ) {
        let documentID = UserDefaults.standard.string(forKey: "\(event.eventURL + "document")")
        db.collection("Users").document(user!).collection("Bookmark").document(documentID!).delete { (err) in
            if let err = err {
                print(err)
            } else {
                completion(event)
                print("deleted.")
            }
        }
    }
}
