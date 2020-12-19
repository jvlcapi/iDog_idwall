import UIKit
import Alamofire

class SignUpViewController: UIViewController {
    weak var delegate: SignUpViewControllerDelegate?
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var signUpButton: UIButton!
    
//    var signUpToken: SignUpToken? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }

    private func configure() {
        // emailTextField
        emailTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 44))
        emailTextField.leftViewMode = .always

        emailTextField.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 44))
        emailTextField.rightViewMode = .always
        
        emailTextField.layer.cornerRadius = 4
        emailTextField.layer.masksToBounds = true
        
        // signUpButton
        signUpButton.layer.cornerRadius = 4
        signUpButton.layer.masksToBounds = true
    }

    @IBAction func signUp(_ sender: UIButton) {
        delegate?.askForAuthorization(email: self.emailTextField.text ?? "someDefaultEmailForTesting")
        
        if let delegateAsCoordinator = delegate as? AppCoordinator {
            guard let token = delegateAsCoordinator.authToken else {print("token==nil");return}
            delegate?.signUpViewControllerDidSignUp(self, authToken: token)
        }
        
    }
}

////MARK: Network layer functions
//extension SignUpViewController{
//    fileprivate func askForAuthorization(email: String){
//
//        AuthServices.signUp(email: email) {
//            [weak self]
//            (result : Result<SignUpToken, APIError>) -> (Void) in
//
//            switch result {
//
//            case .success(let signUpToken):
//                self?.signUpToken = signUpToken
//
//            case .failure(let error):
//                //TODO: treat error
//                print(error)
//            }
//        }
//    }
//}


protocol SignUpViewControllerDelegate: AnyObject {
    
    func signUpViewControllerDidSignUp(_ viewController: SignUpViewController, authToken: SignUpToken)
    
    func askForAuthorization(email: String)
}
