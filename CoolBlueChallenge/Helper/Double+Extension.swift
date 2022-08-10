//
//  Double+Extension.swift
//  CoolBlueChallenge
//
//  Created by Jude on 10/08/2022.
//

import Foundation



extension Double {
    func removeTrailing() -> String {
        let formatter = NumberFormatter()
        let number = NSNumber(value: self)
        formatter.minimumFractionDigits = 1
        formatter.maximumFractionDigits = 16
        return String(formatter.string(from: number) ?? "")
    }
}
