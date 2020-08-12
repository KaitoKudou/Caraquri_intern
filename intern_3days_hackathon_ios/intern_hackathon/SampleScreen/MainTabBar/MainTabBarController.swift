import UIKit

final class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setTab()
    }

    private func setTab() {
        let sampleSearchViewController: UINavigationController = R.storyboard.sampleSearch.instantiateInitialViewController()!

        // 仮ViewController。必要に応じて置き換えてください。
        let dummyViewController = UIViewController()

        setViewControllers([sampleSearchViewController, dummyViewController], animated: false)
    }
}
