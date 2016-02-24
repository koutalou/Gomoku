//
//  GMKManager.swift
//  Gomokunarabe
//
//  Created by Kodama.Kotaro on 2016/02/24.
//  Copyright © 2016年 Money Forward, Inc. All rights reserved.
//

import Foundation

enum Stone: Int {
    case None = 0
    case White = 1
    case Black = 2
}

class GMKManager: NSObject {
    class var sharedInstance: GMKManager {
        struct Singleton {
            static let instance = GMKManager()
        }
        return Singleton.instance
    }
    var nextStone: Stone = .Black
    var viewController: ViewController?
    
    var places:[[Stone]] = [
        [.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None],
        [.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None],
        [.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None],
        [.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None],
        [.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None],
        [.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None],
        [.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None],
        [.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None],
        [.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None],
        [.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None],
        [.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None],
        [.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None],
        [.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None],
        [.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None],
        [.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None],
        [.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None],
        [.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None],
        [.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None],
        [.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None,.None]
    ]
    
    func reset() {
        viewController?.resultView.hidden = true

    }
    
    func tapStone(row: Int, section: Int) -> Stone {
        // 石を置けるかチェック
        if !enableSetStone(row, y: section) {
            return .None
        }
        
        // 石に色情報を設定
        places[row][section] = nextStone
        
        // 勝敗のチェック
        checkStatus(nextStone, row: row, section: section)
        
        // 石のステータス更新と、ボタンの更新処理のために石の情報を返す
        let stoneType = nextStone
        nextStone = nextStone == .Black ? .White : .Black
        return stoneType
    }
    
    func checkStatus(stone: Stone, row: Int, section: Int) {
        
        let xpyz = straightNum(stone, x: row, y: section, xDiff: 1, yDiff: 0)
        let xmyz = straightNum(stone, x: row, y: section, xDiff: -1, yDiff: 0)
        let xpyp = straightNum(stone, x: row, y: section, xDiff: 1, yDiff: 1)
        let xmym = straightNum(stone, x: row, y: section, xDiff: -1, yDiff: -1)
        let xpym = straightNum(stone, x: row, y: section, xDiff: 1, yDiff: -1)
        let xmyp = straightNum(stone, x: row, y: section, xDiff: -1, yDiff: 1)
        let xzyp = straightNum(stone, x: row, y: section, xDiff: 0, yDiff: 1)
        let xzym = straightNum(stone, x: row, y: section, xDiff: 0, yDiff: -1)
        
        if xpyz + xmyz >= 4 {
            win(stone)
            return
        }
        
        if xpyp + xmym >= 4 {
            win(stone)
            return
        }
        
        if xpym + xmyp >= 4 {
            win(stone)
            return
        }

        if xzyp + xzym >= 4 {
            win(stone)
            return
        }
    }
    
    func win(stone: Stone) {
        NSLog("\(stone)の勝ち！", "\(stone)の勝ち！")
        
        viewController?.resultView.hidden = false
        viewController?.resultLabel.text = "\(stone)の勝ち！"
    }
    
    func enableSetStone(x: Int, y: Int) -> Bool {
        if (places[x][y] == .None) {
            return true
        }
        return false
    }
    
    func straightNum(stone: Stone, x:Int, y:Int, xDiff:Int, yDiff:Int) -> Int {
        var nextX: Int = x + xDiff
        var nextY: Int = y + yDiff
        var straightNum = 0
        
        // 範囲外となったので終了
        if (!enableRange(nextX) || !enableRange(nextY)) {
            return straightNum
        }
        
        // 自分の色の石ではないため終了
        if places[nextX][nextY] != stone { //places[nextX][nextY] == .None || places[nextX][nextY] == stone) {
            return straightNum
        }
        
        straightNum++
        
        for (;;) {
            nextX += xDiff
            nextY += yDiff
            
            if (!enableRange(nextX) || !enableRange(nextY)) {
                return straightNum
            }
            
            if (places[nextX][nextY] == stone) {
                straightNum++
                continue
            }
            
            return straightNum
        }
    }
    
    func enableRange(num: Int) -> Bool {
        if (num >= 0 && num <= 18) {
            return true
        }
        return false
    }
}