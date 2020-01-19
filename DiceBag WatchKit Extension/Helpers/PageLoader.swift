//
//  PageLoader.swift
//  DiceBag WatchKit Extension
//
//  Created by Anton Cheremukhin on 20.01.2020.
//  Copyright © 2020 Anton Cheremukhin. All rights reserved.
//

import WatchKit

class PageLoader {
	private static var firstLoad = true
	public static func onAwake() {
		if PageLoader.firstLoad {
			PageLoader.firstLoad = false
			WKInterfaceController.reloadRootControllers(withNamesAndContexts: [
			(name: "D20", context: DiceModel.diceModels[0]),
			(name: "D12", context: DiceModel.diceModels[1]),
			(name: "D10", context: DiceModel.diceModels[2]),
			(name: "D8", context: DiceModel.diceModels[3]),
			(name: "D6", context: DiceModel.diceModels[4]),
			(name: "D4", context: DiceModel.diceModels[5])
			])
		}
	}
}
