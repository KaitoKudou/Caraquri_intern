import Nuke
import UIKit

final class SampleEventListCell: UITableViewCell {
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var titleTextLabel: UILabel!
    @IBOutlet weak var descriptionTextLabel: UILabel!
    
    func set(_ event: Event) {
        titleTextLabel.text = event.title
        descriptionTextLabel.text = "開催地: " +  String(event.address ?? "")
    }
}
