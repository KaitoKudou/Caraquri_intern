//
//  HomrViewCell.swift
//  intern_hackathon
//
//  Created by 神野成紀 on 2020/08/12.
//  Copyright © 2020 caraquri. All rights reserved.
//
import Firebase
import UIKit

protocol HomeViewCellDelegate {
    func reloadCell(indexPath: IndexPath)
}
class HomeViewCell: UITableViewCell {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var startedAt: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var bookmark: UIButton!
    let db = Firestore.firestore()
    var delegate: HomeViewCellDelegate?
    var index: IndexPath!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    @IBAction func tappedBookmark(_ sender: UIButton) {
        delegate?.reloadCell(indexPath: index)
        //        db.collection("Users").document("aaa").collection("Bookmark").addDocument(data: ["startedAt": startedAt.text!, "address": address.text!, "title": title.text!]) { (err) in
        //            guard let err = err else {
        //                print("success")
        //                return
        //            }
        //            print(err)
        //        }
    }
    
    func set(event: HomeViewCellData) {
        startedAt.text = event.event.startedAt
        title.text = event.event.title
        address.text = event.event.address ?? ""
        
        if event.color {
            bookmark.tintColor = .yellow
        } else {
            bookmark.tintColor = .darkGray
        }
    }
    
    func check() {
        if title.text == UserDefaults.standard.string(forKey: "title") {
            bookmark.tintColor = .yellow
        }
    }
}

