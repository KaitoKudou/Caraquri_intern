import UIKit

final class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setTab()
    }

    private func setTab() {
        let sampleSearchViewController: UINavigationController = R.storyboard.sampleSearch.instantiateInitialViewController()!
        
        let calendarViewController: UIViewController = R.storyboard.calendar.instantiateInitialViewController()!

        setViewControllers([sampleSearchViewController, calendarViewController], animated: false)
    }
}
