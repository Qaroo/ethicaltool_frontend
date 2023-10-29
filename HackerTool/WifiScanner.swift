//
//  WifiScanner.swift
//  HackerTool
//
//  Created by עילי בוקובזה on 05/09/2021.
//

import UIKit
import MMLanScan
class WifiScanner: UIViewController {
    var lanScanner : MMLANScanner!

    var ips:[String] = []
    @IBOutlet weak var textPlain: UITextView!
    override func viewDidLoad() {
        self.lanScanner = MMLANScanner(delegate:self)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.textPlain.text = "\(self.textPlain.text!) \nThis task do only wifi scanning work, You also have an access to hack the net and connect the devices, see their history acts and stand in the middle! \n\n-----"
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            self.textPlain.text = "\(self.textPlain.text!) \nstart scanning..."
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
        self.lanScanner.start()
        }

    }
}
extension WifiScanner: MMLANScannerDelegate {
    
    func lanScanDidFindNewDevice(_ device: MMDevice!) {
        if(ips.contains(textPlain.text!)) {
            textPlain.text = "\(textPlain.text!) \nNew Device detected: \(device.ipAddress!) (Known)"
        }else {
        textPlain.text = "\(textPlain.text!) \nNew Device detected: \(device.ipAddress!)"
        print("local \(device.ipAddress!) - \(device.brand!)")
        ips.append(textPlain.text!)
        }
    }
    
    func lanScanDidFinishScanning(with status: MMLanScannerStatus) {
        textPlain.text = "\(textPlain.text!) \nfinish scan"
        print("finish scan")
    }
    
    func lanScanDidFailedToScan() {
        textPlain.text = "\(textPlain.text!) \nscan failed"
        print("failed scan")
    }
}

