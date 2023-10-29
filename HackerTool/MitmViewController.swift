//
//  MitmViewController.swift
//  HackerTool
//
//  Created by עילי בוקובזה on 09/03/2022.
//

import UIKit
import Firebase
import FirebaseFirestore

class MitmViewController: UIViewController {

    @IBOutlet weak var SubmitPanelView: UIView!
    @IBOutlet weak var LogPanelView: UITextView!
    @IBOutlet weak var AttackStatusLayer: UILabel!
    @IBOutlet weak var SubmitButton: UIButton!
    
    @IBOutlet weak var serverIP: UITextField!
    @IBOutlet weak var serverPORT: UITextField!
    @IBOutlet weak var targetIP: UITextField!
    @IBOutlet weak var gatewayIP: UITextField!
    @IBOutlet weak var textField: UITextView!
    var attacking:Bool = false
    
    func switchScreen(status:Bool) {
        if status {
            self.SubmitPanelView.enableMode = .disabled
            self.LogPanelView.enableMode = .enabled
            self.SubmitButton.enableMode = .disabled
        }else{
            self.SubmitPanelView.enableMode = .enabled
            self.LogPanelView.enableMode = .disabled
            self.SubmitButton.enableMode = .enabled

        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.SubmitButton.layer.cornerRadius = 10
        self.SubmitPanelView.layer.cornerRadius = 10
        self.SubmitPanelView.enableMode = .disabled
        self.LogPanelView.enableMode = .disabled
        self.SubmitButton.enableMode = .disabled
        self.LogPanelView.alpha = 1
        self.SubmitButton.alpha = 1
        self.SubmitPanelView.alpha = 1
        
        
        if UserDefaults.standard.string(forKey: "server") == nil || !attacking {
            switchScreen(status: false)
        }else{
            switchScreen(status: true)
        }
        
    }
    
    
    @IBAction func SubmitButton(_ sender: Any) {
        
        if self.SubmitButton.currentTitle == "ReloadData" {
            var code = UserDefaults.standard.string(forKey: "lastmitmkey")
            Firestore.firestore().collection("mitm").document(code!).getDocument { snapsho, err in
                guard err == nil else {
                    self.textField.text = "Error loading log \(err?.localizedDescription)"

                    print("Error loading log \(err?.localizedDescription)")
                    return
                }
                if snapsho!.data() == nil {
                    self.textField.text = "Error loading log"

                }else {
                    self.textField.text = "\(snapsho!.data()!)"
                }
            }
            return
        }
        
        if !attacking {
            
        var iz = "http://\(self.serverIP.text as! String):\(self.serverPORT.text as! String)/mitm"
        
        
        let urlz = URL(string: iz)!
        
        var request = URLRequest(url: urlz)
        request.httpMethod = "POST"
        let parameters: [String: Any] = [
            
            
            "targetip": self.targetIP.text as! String,
            "router" : self.gatewayIP.text as! String
            
          ]
        
        
        request.httpBody = parameters.percentEncoded()

        let taskz = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data,
                let response = response as? HTTPURLResponse,
                error == nil else {                                              // check for fundamental networking error
                print("error", error ?? "Unknown error")
                return
            }

            guard (200 ... 299) ~= response.statusCode else {                    // check for http errors
                print("statusCode should be 2xx, but is \(response.statusCode)")
                print("response = \(response)")
                return
            }

            let responseString = String(data: data, encoding: .utf8) as! String
            print("response:\(responseString)")
            if responseString.contains("task_id") {
                var code = responseString.components(separatedBy: "task_id:")[1] as! String
                
                UserDefaults.standard.set(code, forKey: "lastmitmkey")
                print("code:\(code)")
                self.attacking = true
                
            }
            
        }

        taskz.resume()
            self.SubmitButton.setTitle("Stop", for: .normal)
        }
        if attacking {
            var iz = "http://" + self.serverIP.text! + ":" + self.serverPORT.text! + "/mitm"
        
        
        let urlz = URL(string: iz)!
        
        var request = URLRequest(url: urlz)
        request.httpMethod = "POST"
        let parameters: [String: Any] = [
            
            
            "stop": true
            
          ]
        
        
        request.httpBody = parameters.percentEncoded()

        let taskz = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data,
                let response = response as? HTTPURLResponse,
                error == nil else {                                              // check for fundamental networking error
                print("error", error ?? "Unknown error")
                return
            }

            guard (200 ... 299) ~= response.statusCode else {                    // check for http errors
                print("statusCode should be 2xx, but is \(response.statusCode)")
                print("response = \(response)")
                return
            }

            let responseString = String(data: data, encoding: .utf8) as! String
            print("stop Response: \(responseString)")
            self.attacking = false
            
        }

        taskz.resume()
            self.SubmitButton.setTitle("ReloadData", for: .normal)

        }
    }
    
}
