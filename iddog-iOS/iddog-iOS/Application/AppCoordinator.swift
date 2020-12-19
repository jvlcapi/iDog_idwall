import UIKit

final class AppCoordinator {
    private weak var window: UIWindow?
    
    var authToken: SignUpToken? = nil
    
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
    
    func askForAuthorization(email: String) {
        AuthServices.signUp(email: email) {
            [weak self]
            
            (result : Result<SignUpToken, APIError>) -> (Void) in
            
            
            switch result {
            
            case .success(let signUpToken):
                self?.authToken = signUpToken
                
            case .failure(let error):
                //TODO: treat error
                print(error)
            }
        }
    }
    
    func signUpViewControllerDidSignUp(_ viewController: SignUpViewController, authToken: SignUpToken) {
        UIView.transition(
            with: window!,
            duration: 0.5,
            options: [.transitionFlipFromLeft],
            animations: {
                self.window?.rootViewController = FeedViewController()
                self.authToken = authToken
            }
        )
    }
}
