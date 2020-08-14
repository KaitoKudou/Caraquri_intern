//
//  Book.swift
//  intern_hackathon
//
//  Created by 神野成紀 on 2020/08/14.
//  Copyright © 2020 caraquri. All rights reserved.
//

import Foundation

struct HomeViewCellData {
    let event: Event
    var color: Bool
}

extension HomeViewCellData {
    var changedStartedAt: String {
        return changeDate(event.startedAt!)
    }
    
    func changeDate(_ createdAt: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssXXX"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        let date = formatter.date(from: createdAt)!
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(identifier: "Asia/Tokyo")
        let str = formatter.string(from: date)
        return str
    }
}
