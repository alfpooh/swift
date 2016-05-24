//: Playground - noun: a place where people can play

import UIKit

var playerAscore: Int
var playerBscore: Int

func whoiswinner (playerA:Int, playerB:Int) {
    if playerA == playerB {
    print("The game has a tie score.")
    } else
        if playerA > playerB {
            print("A is winner.")
        } else {
            print("B is winner.")}
}

whoiswinner (4, playerB: 4)







