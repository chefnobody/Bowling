//: Playground - noun: a place where people can play

import Foundation

enum FrameResultType {
    case open
    case strike
    case spare
    case unknown
}

struct FrameResult {
    var number: Int
    var pins: Int
    var type: FrameResultType
}

struct Bowler {
    let name: String
    
    init(name: String) {
        self.name = name
    }
    
    func roll(forRemaining: Int = 10) -> Int {
        return Int(arc4random_uniform(UInt32(forRemaining)) + 1) // Int.random(in: 1...10)
    }
    
    func bowl(frame: Int) -> FrameResult {
        let roll1 = roll()
        
        if roll1 == 10 {
            // striked frame
            return FrameResult(number: frame, pins: 10, type: FrameResultType.strike)
        }
            
        // roll again agains remaining pins..
        let roll2 = roll(forRemaining: 10 - roll1)
        let total = roll1 + roll2
        
        if total == 10 {
            // spared frame
            return FrameResult(number: frame, pins: 10, type: FrameResultType.spare)
        }
        
        // open frame
        return FrameResult(number: frame, pins: total, type: FrameResultType.open)
    }
}

struct Score {
    // number
    
    // unknown,
}

// A Ten-pin Bowling game.
// - Could be serialized to disk
// - Represents the current state of the game.

struct Game {
    let bowlers: [Bowler]
    var currentBowler: Bowler
    var currentFrame: Int
    var scoreSheet: [FrameResult]
    
    init(bowlers: [Bowler]) {
        self.bowlers = bowlers
        self.currentBowler = self.bowlers.first!
        self.currentFrame = 1
        self.scoreSheet = [FrameResult]()
    }
    
    mutating func start() {
        let result = currentBowler.bowl(frame: currentFrame)
        
        scoreSheet.append(result)
        
        stop()
    }
 
    func printScores() {
        
    }
    
    func stop() {
        print(scoreSheet)
        print("-----")
        print("Done!")
    }
}

let bowlers = [Bowler(name: "Aaron")]
var game = Game(bowlers: bowlers)
game.start()


