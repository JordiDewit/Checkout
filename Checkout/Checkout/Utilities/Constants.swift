//
//  Constants.swift
//  Checkout
//
//  Created by Jordi Dewit on 22/12/2021.
//

import Foundation
import SwiftUI

// constants that must be used all the time
struct Constants{
    static let fontSize: CGFloat = 120
    static let fontSize2: CGFloat = 36
    static let crSize: CGFloat = 180
}

enum APIConstants{
    // public url from ngrok file
    static let basicURL = "https://0239-81-245-62-144.ngrok.io/"
}

enum Endpoints {
    static let players = "players"
}
enum Stores {
    static let stores = ["Bakkerij", "Beenhouwerij", "Fruitwinkel", "Groentewinkel", "Speelgoedwinkel", "Sportwinkel"]
}
enum Levels{
    static let levels = ["Makkelijk", "Normaal", "Moeilijk"]
}
