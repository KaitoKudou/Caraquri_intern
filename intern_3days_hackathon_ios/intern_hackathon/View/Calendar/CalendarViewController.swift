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

class CalendarViewController: UIViewController, FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var calendar: FSCalendar!
    @IBOutlet weak var eventTableView: UITableView!
    
    let calendarViewPresenter = CalendarViewPresenter()
    
    //祝日判定用のカレンダークラスのインスタンス
    private let tmpCalendar = Calendar(identifier: .gregorian)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        calendar.appearance.headerDateFormat = "YYYY年MM月"
        calendar.calendarWeekdayView.weekdayLabels[0].text = "日"
        calendar.calendarWeekdayView.weekdayLabels[1].text = "月"
        calendar.calendarWeekdayView.weekdayLabels[2].text = "火"
        calendar.calendarWeekdayView.weekdayLabels[3].text = "水"
        calendar.calendarWeekdayView.weekdayLabels[4].text = "木"
        calendar.calendarWeekdayView.weekdayLabels[5].text = "金"
        calendar.calendarWeekdayView.weekdayLabels[6].text = "土"
        calendar.delegate = self
        calendar.dataSource = self
    }
    
    // 土日・祝日の文字色を変える
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
        
        //祝日判定をする（祝日は赤色で表示する）
        if calendarViewPresenter.judgeHoliday(date: date) {
            return UIColor.red
        }
        //土日の判定を行う（土曜日は青色、日曜日は赤色で表示する）
        let weekDay = calendarViewPresenter.getWeekIndex(date: date)
        if weekDay == 1 { // 日曜日
            return UIColor.red
        } else if weekDay == 7 { // 土曜日
            return UIColor.blue
        }
        
        return nil
    }
    
    // カレンダーの日付が選択されたら実行
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        let tmpDate = Calendar(identifier: .gregorian)
        let month = tmpDate.component(.month, from: date)
        let day = tmpDate.component(.day, from: date)
        print("\(month)月\(day)日をタップした")
        
        let eventInputViewController: UIViewController = R.storyboard.eventInput.instantiateInitialViewController()!
        present(eventInputViewController, animated: true, completion: nil)
    }
    
    // 予定がある日にカレンダーに点を描画
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = eventTableView.dequeueReusableCell(withIdentifier: "inputEventCell", for: indexPath)
        return cell
    }
}
