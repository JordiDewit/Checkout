//
//  Player.swift
//  Checkout
//
//  Created by Jordi Dewit on 22/12/2021.
//

import Foundation

struct Player: Identifiable, Codable{
    var id: UUID?
    var name: String
    var scores: Array<Int32>
}
