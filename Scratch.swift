//
//  Scratch.swift
//  P13-InstaFilter
//
//  Created by Jonathan Tipton on 9/4/23.
//

import Foundation

class Solution {
    func kidsWithCandies(_ candies: [Int], _ extraCandies: Int) -> [Bool] {
        var maxValue = 0
        
        for candy in candies {
            maxValue = max(maxValue, candy)
        }
        
        var boolArray: [Bool] = []
        
        for (index, candy) in candies.enumerated() {
            if (candy + extraCandies) >= maxValue {
                boolArray[index] = true
            } else {
                boolArray[index] = false
            }
        }
        
        return boolArray
    }
}
