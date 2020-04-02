//
//  DemoViewController.swift
//  Sakura
//
//  Created by croberts22 on 04/17/2019.
//  Copyright (c) 2019 croberts22. All rights reserved.
//

import UIKit
import Sakura


class DemoViewController: UIViewController {
    
    @IBOutlet weak var button: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func buttonPressed() {
        let sakura: Sakura = Sakura.shared
        let message: Message = Message(message: "Hello, Sakura! 🌸")
        let petal: Petal = Petal(message: message, style: .standard)
        sakura.display(petal: petal)
    }
    
}

