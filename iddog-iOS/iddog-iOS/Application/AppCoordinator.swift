import UIKit

final class AppCoordinator {
    private weak var window: UIWindow?
    
    init (window: UIWindow?) {
        self.window = window
    }

    func start() {
        let signUpViewController = SignUpViewController()
        signUpViewController.delegate = self
        window?.rootViewController = signUpViewController
        window?.makeKeyAndVisible()
    }
}

extension AppCoordinator: SignUpViewControllerDelegate {
    func signUpViewControllerDidSignUp(_ viewController: SignUpViewController) {
        UIView.transition(
            with: window!,
            duration: 0.5,
            options: [.transitionFlipFromLeft],
            animations: {
                self.window?.rootViewController = FeedViewController()
            }
        )
    }
}
