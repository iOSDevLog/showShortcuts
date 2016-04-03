//
//  ViewController.swift
//  showShortcuts
//
//  Created by huatian on 16/4/3.
//  Copyright © 2016年 iosdevlog. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    // MARK - outlet
    @IBOutlet weak var textField: NSTextField!
    
    // MARK - lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let isAcquirePrivileges = acquirePrivileges()
        if isAcquirePrivileges {
        }
    }

    // MARK - helper
    
    func acquirePrivileges() -> Bool {
        let accessEnabled = AXIsProcessTrustedWithOptions(
            [kAXTrustedCheckOptionPrompt.takeUnretainedValue() as String : true])
        if !accessEnabled {
            print("You need to enable the WriteTyper in the System Prefrences")
        }
        return accessEnabled
    }
}

