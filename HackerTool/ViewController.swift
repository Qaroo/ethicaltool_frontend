//
//  ViewController.swift
//  HackerTool
//
//  Created by עילי בוקובזה on 02/09/2021.
//

import CoreLocation
import UIKit
import SystemConfiguration.CaptiveNetwork
import NetworkExtension
import MMLanScan
import FirebaseAuth
class ViewController: UIViewController {
  
    //
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var joinusButton: UIButton!
    @IBOutlet weak var beefTitleLabel: UILabel!
    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var passTextField: UITextField!
    @IBOutlet weak var bgView: UIView!
    

    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        if Auth.auth().currentUser != nil {
            print("Loged in")
            
            self.performSegue(withIdentifier: "signin", sender: self)
            return
        }
        self.loginButton.layer.cornerRadius = 10
        self.joinusButton.layer.cornerRadius = 10
        self.joinusButton.layer.borderWidth = 1
        self.joinusButton.layer.borderColor = UIColor.init(red: 255/255, green: 0/255, blue: 0/255, alpha: 1).cgColor
        
        let bottomLine1 = CALayer()
        bottomLine1.frame = CGRect(x: 0, y: self.userTextField.frame.height - 10, width: self.userTextField.frame.width - 30, height: 2)
        bottomLine1.backgroundColor = UIColor.white.cgColor
        self.userTextField.borderStyle = .none
        self.userTextField.layer.addSublayer(bottomLine1)
        
        let bottomLine2 = CALayer()
        bottomLine2.frame = CGRect(x: 0, y: self.passTextField.frame.height - 10, width: self.passTextField.frame.width - 30, height: 2)
        bottomLine2.backgroundColor = UIColor.white.cgColor
        self.passTextField.borderStyle = .none
        self.passTextField.layer.addSublayer(bottomLine2)
       
        self.userTextField.textColor = UIColor.white
        self.passTextField.textColor = UIColor.white

        self.bgView.layer.cornerRadius = 10
       
        
        /*
        let status = CLLocationManager.authorizationStatus()
        if status == .authorizedWhenInUse {
            print("status 1")
            updateWiFi()
        } else {
            print("Status 2")
            locationManager.delegate = self
            locationManager.requestWhenInUseAuthorization()
        }
        */
        
        /*for i in 0...10 {
            TryLogin()
        }*/
        
        
        
    }
    var pass = 528370222
    func TryLogin() {
        print("Pass: 0\(pass)")
        let configuration = NEHotspotConfiguration.init(ssid: "Fiber 4K-9CA8", passphrase: "0\(pass)", isWEP: false)
        configuration.joinOnce = true

        NEHotspotConfigurationManager.shared.apply(configuration) { (error) in
            if error != nil {
                if error?.localizedDescription == "already associated."
                {
                    print("Connected")
                }
                else{
                    print("No Connected")
                }
            }
            else {
                print("Error")
                self.pass+=1
                self.TryLogin()
            }
        }
    }
    @IBAction func loginClicked(_ sender: Any) {
        Auth.auth().signIn(withEmail: self.userTextField.text!, password: self.passTextField.text!) { result, error in
            guard error == nil else {
                print("Signin failed")
                let alert = UIAlertController(title: "התראה", message: "שגיאה בניסיון התחברות", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "אישור", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return
            }
            self.performSegue(withIdentifier: "signin", sender: self)
        }
    }
    
   /* func getSSID() -> String? {
        var ssid: String?
        if let interfaces = CNCopySupportedInterfaces() as NSArray? {
            for interface in interfaces {
                if let interfaceInfo = CNCopyCurrentNetworkInfo(interface as! CFString) as NSDictionary? {
                    ssid = interfaceInfo[kCNNetworkInfoKeySSID as String] as? String
                    break
                }
            }
        }
        return ssid
    }
    func updateWiFi() {
        print("updating")
        //print("SSID: \(currentNetworkInfos?.first?.ssid)")
        self.userTextField.text = getSSID()
        print("SSID: \(getSSID())")
    }*/

}
/*extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            updateWiFi()
        }
    }
}*/
