//
//  CalendarViewController.swift
//  intern_hackathon
//
//  Created by 工藤海斗 on 2020/08/12.
//  Copyright © 2020 caraquri. All rights reserved.
//

import CalculateCalendarLogic
import FSCalendar
import UIKit

class CalendarViewController: UIViewController, FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
    @IBOutlet weak var calendar: FSCalendar!
    let dayOfTheWeeks = ["日": 0, "月": 1, "火": 2, "水": 3, "木": 4, "金": 5, "土": 6]
    
    //祝日判定用のカレンダークラスのインスタンス
    private let tmpCalendar = Calendar(identifier: .gregorian)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        calendar.delegate = self
        calendar.dataSource = self
    }
    
    // 土日・祝日の文字色を変える
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
        
        //祝日判定をする（祝日は赤色で表示する）
        if judgeHoliday(date: date) {
            return UIColor.red
        }
        //土日の判定を行う（土曜日は青色、日曜日は赤色で表示する）
        let weekDay = getWeekIndex(date: date)
        if weekDay == 1 { // 日曜日
            return UIColor.red
        } else if weekDay == 7 { // 土曜日
            return UIColor.blue
        }
        
        return nil
    }
    
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
}
