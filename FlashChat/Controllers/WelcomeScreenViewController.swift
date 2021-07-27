//
//  ViewController.swift
//  FlashChat
//
//  Created by Binaya on 30/05/2021.
//

import UIKit
import CLTypingLabel

class WelcomeScreenViewController: UIViewController {

    @IBOutlet weak var titleLabel: CLTypingLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = "⚡️FLASH CHAT"
        
    }


}

