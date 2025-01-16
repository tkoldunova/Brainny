//
//  File.swift
//  Brainny
//
//  Created by Anastasia Koldunova on 07.01.2025.
//


import UIKit


extension Date {

    static func - (lhs: Date, rhs: Date) -> TimeInterval {
        return lhs.timeIntervalSinceReferenceDate - rhs.timeIntervalSinceReferenceDate
    }

}
