//
//  ViewController.swift
//  Quotes
//
//  Created by Dear D on 11/01/24.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func BtbCatagory(_ sender: Any) {
        let D = storyboard?.instantiateViewController(withIdentifier: "CatagoryVC") as! CatagoryViewController
        self.navigationController?.pushViewController(D, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }


}

