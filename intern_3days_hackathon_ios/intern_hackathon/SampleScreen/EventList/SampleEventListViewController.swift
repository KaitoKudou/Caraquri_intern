import SafariServices
import UIKit

final class SampleEventListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var events: [Event] = []

    static func makeInstance(_ events: [Event]) -> SampleEventListViewController {
        let sampleEventListViewController = R.storyboard.sampleEventList.instantiateInitialViewController()!
        sampleEventListViewController.events = events
        return sampleEventListViewController
    }

    override func viewDidLoad() {
        tableView.register(R.nib.sampleEventListCell)
        tableView.reloadData()
    }
}

extension SampleEventListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.sampleEventListCell, for: indexPath),
            let event = events[safe: indexPath.row] else { return UITableViewCell() }
        
        cell.set(event)
        return cell
    }
}

extension SampleEventListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        guard let urlString = events[safe: indexPath.row]?.eventURL,
            let url = URL(string: urlString) else { return }
        
        let safariViewController = SFSafariViewController(url: url)
        present(safariViewController, animated: true)
    }
}
