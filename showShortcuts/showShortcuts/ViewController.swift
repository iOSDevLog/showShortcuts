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
            self.showShortcuts()
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
    
    func showShortcuts() {
        NSEvent.addGlobalMonitorForEventsMatchingMask(NSEventMask.KeyDownMask, handler : { (theEvent : NSEvent) in
            let flags = theEvent.modifierFlags.rawValue
            var msg = ""
            
            if (flags & NSEventModifierFlags.AlphaShiftKeyMask.rawValue) != 0 {
                msg += "⇪ "
            }
            if (flags & NSEventModifierFlags.ShiftKeyMask.rawValue) != 0 {
                msg += "⇧ "
            }
            if (flags & NSEventModifierFlags.ControlKeyMask.rawValue) != 0 {
                msg += "⌃ "
            }
            if (flags & NSEventModifierFlags.AlternateKeyMask.rawValue) != 0 {
                msg += "⌥ "
            }
            if (flags & NSEventModifierFlags.CommandKeyMask.rawValue) != 0 {
                msg += "⌘ "
            }
            //                if (flags & NSEventModifierFlags.FunctionKeyMask.rawValue) != 0 {
            //                    msg += "F "
            //                }
            //                if (flags & NSEventModifierFlags.NumericPadKeyMask.rawValue) != 0 {
            //                    msg += "⟲"
            //                }
            //                if (flags & NSEventModifierFlags.HelpKeyMask.rawValue) != 0 {
            //                    msg += "Helper "
            //                }
            //                if (flags & NSEventModifierFlags.DeviceIndependentModifierFlagsMask.rawValue) != 0 {
            //                    msg += "Dev "
            //                }
            
            if msg.characters.count > 0 {
                if let c = keyCodeToChar(theEvent.keyCode) {
                    msg += c
                    self.textField.stringValue = msg
//                    NSApp.activateIgnoringOtherApps(true)
                    NSApp.unhide(self)
                    
                    let delayInSeconds = 1.0
                    let hideTime = dispatch_time(DISPATCH_TIME_NOW,
                        Int64(delayInSeconds * Double(NSEC_PER_SEC)))
                    dispatch_after(dispatch_time(hideTime, 1), dispatch_get_main_queue(), {
                        NSApp.hide(self)
                    })
                }
            }
        })
    }
}

