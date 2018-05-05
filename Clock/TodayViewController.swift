//
//  TodayViewController.swift
//  Clock
//
//  Created by Allen Humphreys on 5/4/18.
//  Copyright © 2018 Allen. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {

    var timer: DispatchSourceTimer?

    @IBOutlet weak var clockLabel: UILabel!

    var timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
//        formatter.dateFormat = "hh:mm:ss.SS" // more precise, higher CPU
        formatter.dateFormat = "hh:mm:ss.S"

        return formatter
    }()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        timer = DispatchSource.makeTimerSource(queue: .main)

//        timer?.schedule(deadline: .now(), repeating: .milliseconds(10)) // more precise, higher CPU
        timer?.schedule(deadline: .now(), repeating: .milliseconds(100))

        timer?.setEventHandler { [weak self] in
            self?.updateClock()
        }

        timer?.resume()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        timer?.cancel()
        timer = nil
    }

    func updateClock() {
        clockLabel.text = timeFormatter.string(from: Date())
    }
}
