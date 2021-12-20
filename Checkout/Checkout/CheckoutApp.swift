//
//  CheckoutApp.swift
//  Checkout
//
//  Created by Jordi Dewit on 23/11/2021.
//

import SwiftUI

@main
struct CheckoutApp: App {
    
    private let startViewModel = StartViewModel()
    private let nextViewModel  = CheckoutViewModel()
    
    
    var body: some Scene {
        WindowGroup {
            StartView(startViewModel: startViewModel, nextViewModel: nextViewModel)
        }
    }
}
