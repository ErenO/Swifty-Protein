
import UIKit
import LocalAuthentication
import ChameleonFramework

class LoginViewController: UIViewController {
    
    @IBOutlet weak var enter: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var touchId: UIButton!
    
    @IBOutlet weak var enterBtn: UIButton!
    var lacontext: LAContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lacontext = LAContext()
        self.setUi()
        enterBtn.layer.cornerRadius = 4
    }
    
    func setUi() {
        
        self.view.backgroundColor = UIColor.flatWhite
        if lacontext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil) {
            self.touchId.isHidden = false
            self.passwordTextField.isHidden = true
            self.enter.isHidden = true
        }
        else {
            self.touchId.isHidden = true
            self.passwordTextField.isHidden = false
            self.enter.isHidden = false
        }
    }
    @IBAction func clickEnter(_ sender: Any) {
        self.goToTable()
    }
    
    func showTouchId() {
        if lacontext.canEvaluatePolicy(.deviceOwnerAuthentication, error: nil) {
            lacontext.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: "Please verify yourself", reply: {(isYou, error) in
                DispatchQueue.main.async {
                    if isYou {
                        print("Do segue")
                        self.goToTable()
                    }
                    else {
//                        DispatchQueue.main.async {
//                            let alert = UIAlertController(title: "Error", message: "something went wrong", preferredStyle: .alert)
//                            alert.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
//                            self.present(alert, animated: true, completion: nil)
//                        }
                    }
                }
            })
        }
        else {
            self.touchId.isHidden = true
        }
    }
    
    @IBAction func clickFingerprint(_ sender: Any) {
        self.showTouchId()
    }
    
    func goToTable() {
        self.performSegue(withIdentifier: "LoginToTable", sender: nil)
    }
    
}

