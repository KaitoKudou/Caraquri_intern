//
//  EventInputViewPresenter.swift
//  intern_hackathon
//
//  Created by 工藤海斗 on 2020/08/13.
//  Copyright © 2020 caraquri. All rights reserved.
//

import Firebase
import Foundation

class EventInputViewPresenter {
    
    let db = Firestore.firestore()
    var eventPlan: [EventPlan] = []
    
    // firebaseにイベントを登録する
    func addEvent(date: String, place: String, memo: String) {
        var ref: DocumentReference?
        ref = db.collection("events").addDocument(data: [
            "date": date,
            "place": place,
            "memo": memo
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
    }
    
    // firebaseに登録されているイベントを読み出す
    func fetchEvent() {
        db.collection("events").getDocuments { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    self.eventPlan.append(EventPlan(docement: document))
                    print(self.eventPlan)
                }
            }
        }
    }
}
