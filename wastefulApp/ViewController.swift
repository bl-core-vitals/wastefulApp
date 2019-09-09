//
//  ViewController.swift
//  wastefulApp
//
//  Created by IHsan HUsnul on 14/08/19.
//  Copyright © 2019 IHsan HUsnul. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var attemptLbl: UIButton!
    @IBOutlet weak var label: UILabel!
    var counter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func didTapAllocation(_ sender: Any) {
        counter += 1
        allocation()
        updateLabel()
    }
    
    func allocation() {
        // here is how to allocate 101 mb of ram
        for _ in 0...100 {
            var p: [UnsafeMutableRawPointer] = []
            var allocatedMB = 0
            p.append(malloc(1048576))
            memset(p[allocatedMB], 0, 1048576);
            allocatedMB += 1;
        }
    }
    
    func updateLabel() {
        attemptLbl.setTitle("Attempt \(counter) Allocation", for: .normal)
        label.text = reportMemory()
    }
    
    func reportMemory() -> String {
        var taskInfo = mach_task_basic_info()
        var count = mach_msg_type_number_t(MemoryLayout<mach_task_basic_info>.size)/4
        let kerr: kern_return_t = withUnsafeMutablePointer(to: &taskInfo) {
            $0.withMemoryRebound(to: integer_t.self, capacity: 1) {
                task_info(mach_task_self_, task_flavor_t(MACH_TASK_BASIC_INFO), $0, &count)
            }
        }
        
        if kerr == KERN_SUCCESS {
            let inMega = taskInfo.resident_size / 1048576
            return "Memory used: \(inMega)MB"
        } else {
            return "Error with task_info(): " +
                (String(cString: mach_error_string(kerr), encoding: String.Encoding.ascii) ?? "unknown error")
        }
    }
}

