//
//  DiceModel.swift
//  DiceBag WatchKit Extension
//
//  Created by Anton Cheremukhin on 18.01.2020.
//  Copyright © 2020 Anton Cheremukhin. All rights reserved.
//

import UIKit

class DiceModel: NSObject {
	let image: UIImage?
	let numberOfSides: Int
	
	init(image: UIImage?, numberOfSides: Int) {
		self.image = image
		self.numberOfSides = numberOfSides
	}
}

extension DiceModel {
	static var diceModels: [DiceModel] = [
	DiceModel(image: UIImage(named: "d20_icon"), numberOfSides: 20),
	DiceModel(image: UIImage(named: "D12"), numberOfSides: 12),
	DiceModel(image: UIImage(named: "D10"), numberOfSides: 10),
	DiceModel(image: UIImage(named: "D8"), numberOfSides: 8),
	DiceModel(image: UIImage(named: "D6"), numberOfSides: 6),
	DiceModel(image: UIImage(named: "D4"), numberOfSides: 4)
	]
}
