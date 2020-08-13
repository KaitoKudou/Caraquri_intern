//
//  CalendarViewPresenter.swift
//  intern_hackathon
//
//  Created by 工藤海斗 on 2020/08/13.
//  Copyright © 2020 caraquri. All rights reserved.
//

import CalculateCalendarLogic
import Firebase
import Foundation

class CalendarViewPresenter {
    
    //祝日判定用のカレンダークラスのインスタンス
    private let tmpCalendar = Calendar(identifier: .gregorian)
    let db = Firestore.firestore()
    
    // 祝日判定を行い結果を返すメソッド(True:祝日)
    func judgeHoliday(date: Date) -> Bool {
         // 祝日判定を行う日にちの年、月、日を取得
        let year = tmpCalendar.component(.year, from: date)
        let month = tmpCalendar.component(.month, from: date)
        let day = tmpCalendar.component(.day, from: date)
        
        // CalculateCalendarLogic()：祝日判定のインスタンスの生成
        let holiday = CalculateCalendarLogic()
        
        return holiday.judgeJapaneseHoliday(year: year, month: month, day: day)
    }
    
    // 曜日判定(日曜日:1 〜 土曜日:7)
    func getWeekIndex(date: Date) -> Int {
        return tmpCalendar.component(.weekday, from: date)
    }
    
    func addEvent(day: Date, month: Date, place: String, memo: String) {
        var ref: DocumentReference? = nil
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
