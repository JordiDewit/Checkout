//  Created by Jordi Dewit on 23/11/2021.
//  This will be the model for this checkout game

import Foundation
import SwiftUI

struct Store{
    private(set) var name: String?
    private(set) var products: Array<Product> = []
    private(set) var productOnScreen: Product = Product(id: 0, img: "", price: 0)
    private(set) var imgs: Array<String> = []
    private(set) var score: Int = 0
    private(set) var payed: Double = 0
    private(set) var endOfGame: Bool = false
    
    private let maxProducts: Int = 5
    
    //INITIALISER
    
    init(){
        buildStore()
    }
    
    mutating func buildStore(){
        // clear list
        products = []
        
        // check store options
        switch(name){
        case "Beenhouwerij":
            imgs = KindsOfProducts.butcher
        case "Groentewinkel":
            imgs = KindsOfProducts.veggieFarmer
        case "Fruitwinkel":
            imgs = KindsOfProducts.fruitShop
        case "Speelgoedwinkel":
            imgs = KindsOfProducts.toyStore
        case "Sportwinkel":
            imgs = KindsOfProducts.sportStore
        default:
            imgs = KindsOfProducts.bakery
        }

        // filling an array of 5 products
        for i in 0..<maxProducts{
            let emo: String = imgs[i]
            let price: Double = round((Double.random(in: 1..<1000)))/100
            products.append(Product(id: i+1, img: emo, price: price))
        }
        self.productOnScreen = products[0]
    }
    
    //FUNCTIONS
    mutating func setName(storeOption: String){
        self.name = storeOption
        // rebuild store because store option changed
        // if not equal to default Bakkerij
        if name != "Bakkerij"{
            buildStore()
        }
        
    }
    
    mutating func getNextProduct(){
        let i = products.firstIndex(where: {
            $0.id == productOnScreen.id
        })!
        
        if i == 0 || i+1 < maxProducts{
            productOnScreen = products[i+1]
        }else{
            endOfGame.toggle()
        }
    }
    
    mutating func giveMoney(payed value: Double){
        payed += value
    }
    
    mutating func pay(payed value: Double, for product: Product){
        //make sure that payed value is rounded correctly
        payed = round(value*100)/100
        if payed == product.price{
            score+=1
        }
        payed = 0
        getNextProduct()
    }
    
    //STRUCTS
    struct Product: Identifiable, Equatable{
        
        let id: Int
        let img: String
        let price: Double
        
        //initialising from a product instance
        init(id: Int, img: String, price: Double){
            self.id    = id
            self.img   = img
            self.price = price
        }
        
    }
}

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






