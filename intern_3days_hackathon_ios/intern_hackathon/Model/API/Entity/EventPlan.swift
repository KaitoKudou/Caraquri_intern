//
//  EventPlan.swift
//  intern_hackathon
//
//  Created by 工藤海斗 on 2020/08/13.
//  Copyright © 2020 caraquri. All rights reserved.
//

import Firebase
import Foundation

struct EventPlan {
    let place: String
    let date: String
    let memo: String
    
    init(docement: QueryDocumentSnapshot) {
        self.place = docement.get("place") as? String ?? ""
        self.date = docement.get("date") as? String ?? ""
        self.memo = docement.get("memo") as? String ?? ""
    }
}
