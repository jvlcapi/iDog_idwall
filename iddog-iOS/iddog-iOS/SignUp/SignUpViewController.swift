import UIKit

class SignUpViewController: UIViewController {
    weak var delegate: SignUpViewControllerDelegate?
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var signUpButton: UIButton!

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
        delegate?.signUpViewControllerDidSignUp(self)
    }
}

protocol SignUpViewControllerDelegate: AnyObject {
    func signUpViewControllerDidSignUp(_ viewController: SignUpViewController)
}
