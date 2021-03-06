import UIKit

final class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setTab()
    }

    private func setTab() {
        let homeViewController: UINavigationController = R.storyboard.home.instantiateInitialViewController()!
        let calendarViewController: UIViewController = R.storyboard.calendar.instantiateInitialViewController()!

        // 仮ViewController。必要に応じて置き換えてください。
        let dummyViewController = UIViewController()

        setViewControllers([homeViewController, dummyViewController, calendarViewController], animated: false)
    }
}
