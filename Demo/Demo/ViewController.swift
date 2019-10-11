//
//  ViewController.swift
//  Demo
//
//  Created by PCIT46 on 9/11/19.
//  Copyright © 2019 PCIT46. All rights reserved.
//

import UIKit

class ViewController: UIViewController, XMLParserDelegate, nbDelegate, cardDelegate {
    
    
    
    @IBAction func btnTApped(_ sender: Any) {
        
        let netB = nb()
        netB.myDelegate = self
        netB.loginid = "197"//459   197 NEW
        netB.txnscamt = "0"
        netB.password = "Test@123"
        netB.prodid = "NSE"
        netB.txncurr = "INR"
        netB.clientcode = "001"
        netB.custacc = "100000036600"
        netB.amt = "100.00"
        netB.txnid = "M125"
        netB.date = "20/05/2020 12:16:39"
        netB.reqHashKey = "KEY123657234"
        netB.resHashKey = "KEYRESP123657234"
        //netB.bankid=@"2001";
        
        
        present(netB, animated: true)
        
    }
    
    func secondviewcontrollerDissmissed(_ stringToFirst: String?) {
        var getResult: String
        getResult = stringToFirst ?? ""
        print("received---->\(getResult)")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

