//
//  InterfaceController.swift
//  DiceBag WatchKit Extension
//
//  Created by Anton Cheremukhin on 17.01.2020.
//  Copyright © 2020 Anton Cheremukhin. All rights reserved.
//

import WatchKit
import Foundation

extension DicePageController {
	enum Constants {
		static let scrollTreshold: Double = 0.08
		static let lowerDiceCount = 1
		static let upperDiceCount = 10
		static let diceImageSize = CGSize(width: 140, height: 140)
	}
}

class DicePageController: WKInterfaceController {
	@IBOutlet weak var diceRollGroup: WKInterfaceGroup?
	@IBOutlet weak var diceRollResultLabel: WKInterfaceLabel?
	@IBOutlet weak var diceCountLabel: WKInterfaceLabel?
	
	
	@IBOutlet weak var subrollResultLabel: WKInterfaceLabel?
	
	private var dice: DiceModel?
	private var result: [Int] = []
	
	// Count dices with crown
	private var crownDelta: Double = 0
	private var diceCount: Int = 1
	
	
	private static var firstLoad = true
	
	override func awake(withContext context: Any?) {
		super.awake(withContext: context)
		if DicePageController.firstLoad {
			DicePageController.firstLoad = false
			WKInterfaceController.reloadRootControllers(withNamesAndContexts: [
			(name: "D20", context: DiceModel.diceModels[0]),
			(name: "D12", context: DiceModel.diceModels[1]),
			(name: "D10", context: DiceModel.diceModels[2]),
			(name: "D8", context: DiceModel.diceModels[3]),
			(name: "D6", context: DiceModel.diceModels[4]),
			(name: "D4", context: DiceModel.diceModels[5])
			])
			return
		}
		dice = context as? DiceModel
		diceRollGroup?.setWidth(Constants.diceImageSize.width)
		diceRollGroup?.setHeight(Constants.diceImageSize.height)
	}
	
	override func willActivate() {
		super.willActivate()
		guard let dice = dice else { return }
		diceRollGroup?.setBackgroundImage(dice.image)
		setResult(result, haptic: nil)
		setCount(diceCount, haptic: nil)
	}
	
	override func didAppear() {
		super.didAppear()
		crownSequencer.delegate = self
		crownSequencer.focus()
	}

	@IBAction func DiceTapped(_ sender: Any) {
		guard let dice = dice else { return }
		var resultValue: [Int] = []
		for _ in 0..<diceCount {
			resultValue.append(dice.roll())
		}
		setResult(resultValue, haptic: .click)
	}
	
	private func setResult(_ result: [Int], haptic: WKHapticType?) {
		self.result = result
		let fullResult = result.reduce(0) { (result, value) -> Int in
			result + value
		}
		diceRollResultLabel?.setText(fullResult > 0 ? "\(fullResult)" : nil)
		
		var subrollText = ""
		if result.count > 1 {
			for i in 0..<result.count {
				if i == 5 {
					subrollText += "\n"
				}
				else if i > 0 {
					subrollText += "+"
				}
				subrollText += "\(result[i])"
			}
		}
		subrollResultLabel?.setText(subrollText)
		
		guard let haptic = haptic else { return }
		WKInterfaceDevice.current().play(haptic)
	}
	
	private func setCount(_ count: Int, haptic: WKHapticType?) {
		self.diceCount = count.clamp(between: Constants.lowerDiceCount, and: Constants.upperDiceCount)
		diceCountLabel?.setText("x \(self.diceCount)")
		guard let haptic = haptic, self.diceCount == count else { return }
		WKInterfaceDevice.current().play(haptic)
	}
}

extension DicePageController: WKCrownDelegate {
	func crownDidRotate(_ crownSequencer: WKCrownSequencer?, rotationalDelta: Double) {
		crownDelta += rotationalDelta
		if crownDelta > Constants.scrollTreshold {
			setCount(diceCount + 1, haptic: .click)
			crownDelta = 0
		}
		else if crownDelta < -Constants.scrollTreshold {
			setCount(diceCount - 1, haptic: .click)
			crownDelta = 0
		}
	}
}
