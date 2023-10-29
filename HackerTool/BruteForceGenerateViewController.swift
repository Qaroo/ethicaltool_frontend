//
//  BruteForceGenerateViewController.swift
//  HackerTool
//
//  Created by עילי בוקובזה on 13/03/2022.
//

import UIKit

class BruteForceGenerateViewController: UIViewController {

    @IBOutlet weak var typeTF: UITextField!
    @IBOutlet weak var generateButton: UIButton!
    @IBOutlet weak var bruteForceButton: UIButton!
    @IBOutlet weak var saveFIlePassword: UIButton!
    @IBOutlet weak var passwordsTF: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.generateButton.layer.cornerRadius = 20
        self.bruteForceButton.layer.cornerRadius = 20
        self.saveFIlePassword.layer.cornerRadius = 20
        
        
        if UserDefaults.standard.stringArray(forKey: "bfkeywords") != nil {
            for pass in UserDefaults.standard.stringArray(forKey: "bfkeywords")! {
                self.passwordsTF.text = self.passwordsTF.text + "\n" + pass
            }
        }else {
            self.passwordsTF.text = "No Passwords File found"
        }
    }
    
    
    
    @IBAction func generatePassword(_ sender: Any) {
        var passwords = self.typeTF.text!
        
        self.passwordsTF.text = "Generate passwords file..."
        
        var iz = "https://Brute.selllit.repl.co/generate"
        
        
        let urlz = URL(string: iz)!
        
        var request = URLRequest(url: urlz)
        request.httpMethod = "POST"
        let parameters: [String: Any] = [
            
            
                "keywords": passwords
            
          ]
        
        print("Parameters: \(parameters)")
        
        request.httpBody = parameters.percentEncoded()

        let taskz = URLSession.shared.dataTask(with: request) { data, response, error in
            print("sending")
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
            
            if responseString.components(separatedBy: ":")[0].contains("passwords") {
                var last = responseString.components(separatedBy: ":")[1] as! String
                last = last.replacingOccurrences(of: "[", with: "")
                last = last.replacingOccurrences(of: "]", with: "")
                last = last.replacingOccurrences(of: "}", with: "")
                last = last.replacingOccurrences(of: "\"", with: "")
                print("Last \(last)")
                var arr = last.split(separator: ",")
                UserDefaults.standard.set(arr, forKey: "bfkeywords")
                DispatchQueue.main.async {
                    self.passwordsTF.text = ""
                    for pass in arr {
                        self.passwordsTF.text = self.passwordsTF.text + "\n" + pass
                    }
                }
                
            }
            
        }

        taskz.resume()
        
    }
    

   
}
extension Dictionary {
    func percentEncoded() -> Data? {
        return map { key, value in
            let escapedKey = "\(key)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            let escapedValue = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            return escapedKey + "=" + escapedValue
        }
        .joined(separator: "&")
        .data(using: .utf8)
    }
}

extension CharacterSet {
    static let urlQueryValueAllowed: CharacterSet = {
        let generalDelimitersToEncode = ":#[]@" // does not include "?" or "/" due to RFC 3986 - Section 3.4
        let subDelimitersToEncode = "!$&'()*+,;="
        
        var allowed = CharacterSet.urlQueryAllowed
        allowed.remove(charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")
        return allowed
    }()
}
