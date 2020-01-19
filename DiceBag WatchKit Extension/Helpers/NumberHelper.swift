//
//  NumberHelper.swift
//  DiceBag WatchKit Extension
//
//  Created by Anton Cheremukhin on 18.01.2020.
//  Copyright © 2020 Anton Cheremukhin. All rights reserved.
//

import UIKit

extension Int {
	func clamp(between lowerValue: Int, and upperValue: Int) -> Int {
		guard lowerValue < upperValue else { return self }
		guard self >= lowerValue else { return lowerValue }
		guard self <= upperValue else { return upperValue }
		return self
	}
}
