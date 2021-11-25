//
//  CheckoutApp.swift
//  Checkout
//
//  Created by Jordi Dewit on 23/11/2021.
//

import SwiftUI

@main
struct CheckoutApp: App {
    
    private let viewModel = CheckoutViewModel()
    
    
    var body: some Scene {
        WindowGroup {
            CheckoutView(viewModel: viewModel)
        }
    }
}
