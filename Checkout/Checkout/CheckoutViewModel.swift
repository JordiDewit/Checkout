//  Created by Jordi Dewit on 23/11/2021.
//  This is the viewmodel for checkout game

import Foundation
import SwiftUI


class CheckoutViewModel: ObservableObject
{
    // model with which we communicate
    @Published private var model = buildStore()
    static var defaultStore: String = "Bakkerij"
    
    typealias Product = Store.Product

    // computed property with products
    var products: Array<Store.Product>{
      return model.products
    }
    
    var productOnScreen: Product {
        return model.productOnScreen
    }
    
    var payed: Double {
        return model.payed
    }
    
    // building the store (game)
    static func buildStore() -> Store {
        return Store()
    }
    func setName(store: String){
        model.setName(storeOption: store)
    }
    
    // getter for the storename
    func getStoreName() -> String{
        return model.name!
    }
    
    // get cash (levels must be still implemented)
    func getCash() -> Array<Double>{
        return Money.hardMoney
    }
    
    // getter for the next product
    func getNextProduct(){
        model.getNextProduct()
    }
    // getter to collect te money
    func giveMoney(payed value: Double){
        model.giveMoney(payed: value)
    }
    
    // function to pay the product
    func pay(for product: Product){
        model.pay(payed: payed, for: product)
    }
    // getter for score
    func getScore() -> Int{
        return model.score
    }
    // check if it is the end of the game
    func isOver() -> Bool {
        return model.endOfGame
    }
 
    // different kinds of products depending of kind of store the user has chosen
    struct KindsOfProducts {
        static let bakery       = ["🥖","🍞","🥯","🥐","🧇","🥞","🥨","🥧","🍰","🧁","🍪","🍩"]
        static let butcher      = ["🥩","🥓","🍖","🍗","🦴","🍔"]
        static let veggieFarmer = ["🥦", "🥬", "🥕", "🫑","🧄", "🧅", "🍠","🌽", "🍆"]
        static let fruitShop    = ["🍏","🍎","🍊","🍋","🍉","🍇","🍓","🫐","🍌","🍑"]
        static let toyStore     = ["🚗","🏎","🛴","🚲","🚜","🚎","✈️","🛶","🚁"]
        static let sportStore   = ["⚽️","🏀","🏈","🏓","🪃","🥋","⛸","🛼","🤿","🥅"]
    }
    
    //The money values which depend on the chosen Level
    struct Money {
        static let easyMoney: Array<Double>   =  [10,5,2,1]
        static let mediumMoney: Array<Double> =  [20,10,5,2,1,0.5,0.2,0.1]
        static let hardMoney: Array<Double>   =  [50,20,10,5,2,1,0.5,0.2,0.1,0.05,0.02,0.01]
    }
    
    //The store options for choosing which kinds of products they want to buy
    struct StoreOptions {
        static let bakery       = "Bakkerij"
        static let butcher      = "Beenhouwerij"
        static let veggieFarmer = "Groentewinkel"
        static let fruitshop    = "Fruitwinkel"
        static let toyStore     = "Speelgoedwinkel"
        static let sportStore   = "Sportwinkel"
    }
}






