import UIKit

final class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setTab()
    }

    private func setTab() {
<<<<<<< HEAD
        let sampleSearchViewController: UINavigationController = R.storyboard.sampleSearch.instantiateInitialViewController()!
        
        let calendarViewController: UIViewController = R.storyboard.calendar.instantiateInitialViewController()!
        
        // 仮ViewController。必要に応じて置き換えてください。
        let dummyViewController = UIViewController()

        setViewControllers([sampleSearchViewController, dummyViewController, calendarViewController], animated: false)
=======
        let homeViewController: UINavigationController = R.storyboard.home.instantiateInitialViewController()!

        // 仮ViewController。必要に応じて置き換えてください。
        let dummyViewController = UIViewController()

        setViewControllers([homeViewController, dummyViewController], animated: false)
>>>>>>> develop
    }
}
