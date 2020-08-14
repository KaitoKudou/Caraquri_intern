import UIKit

final class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setTab()
    }

    private func setTab() {
        let homeViewController: UINavigationController = R.storyboard.home.instantiateInitialViewController()!
        homeViewController.tabBarItem = UITabBarItem(tabBarSystemItem: UITabBarItem.SystemItem.search, tag: 1)
        
        let calendarViewController: UIViewController = R.storyboard.calendar.instantiateInitialViewController()!
        calendarViewController.tabBarItem = UITabBarItem(tabBarSystemItem: UITabBarItem.SystemItem.mostViewed, tag: 2)
        
        setViewControllers([homeViewController, calendarViewController], animated: false)
    }
}
