import UIKit

public enum Page: Int {
    case overview = 0
    case aperture = 1
    case shutter = 2
    case iso = 3
    case focal = 4
    case modes = 5
}

public enum Segment: Int {
    case intro = 0
    case demo = 1
    case practice = 2
}

public struct TutorialSetUp {
    let currentPage: Page
    let currentSegment: Segment?
    public init(currentPage: Page, currentSegment: Segment?) {
        self.currentPage = currentPage
        self.currentSegment = currentSegment
    }
}

extension UINavigationController {
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return topViewController?.preferredStatusBarStyle ?? .default
    }
}

final class HomeViewController: UIViewController {
    var content: Content?
    
    override func loadView() {
        let photographyModel = PhotographyModel()
        let homeView = HomeView()
        view = homeView
        view.backgroundColor = UIColor.backgroundColor()
        title = "Lambent"
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName: UIFont.systemFont(ofSize: 24)]
        navigationController?.hidesBarsOnSwipe = true
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Home", style: .plain, target: self, action: nil)
        ViewControllerBinding.bind(view: homeView, viewController: self, model: photographyModel)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override var prefersStatusBarHidden: Bool {
        return navigationController?.isNavigationBarHidden ?? false
    }
    
    
    func pushTutorialViewController(setUp: TutorialSetUp) -> Void {
        guard let content = content else { return }
        navigationController?.pushViewController(TutorialViewController(setUp: setUp, content: content), animated: true)
    }
}

struct ViewControllerBinding {
    static func bind (view: HomeView, viewController: HomeViewController, model: PhotographyModel) {
        model.fetchCachedImages { DemoView.images = $0.0; DemoView.cache = $0.1 }
        model.fetchContent{ viewController.content = $0; view.homeContent = $0 }
        view.navigationController = viewController.navigationController
        view.startTutorial = viewController.pushTutorialViewController
    }
}

