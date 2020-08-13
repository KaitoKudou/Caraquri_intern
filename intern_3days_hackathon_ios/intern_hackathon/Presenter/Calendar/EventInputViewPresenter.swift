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
    
    // firebaseにイベントを登録する
    func addEvent(day: Date, month: Date, place: String, memo: String) {
        var ref: DocumentReference?
        ref = db.collection("events").addDocument(data: [
            "date": "\(month)/\(day)",
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
}
