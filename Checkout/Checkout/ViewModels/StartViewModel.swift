//
//  File.swift
//  Checkout
//
//  Created by Jordi Dewit on 20/12/2021.
//

import Foundation

class StartViewModel: ObservableObject{
    @Published var storeOption: String = "Bakkerij"
    @Published var level: String = "Makkelijk"
    @Published var playerName: String = ""
    
}


