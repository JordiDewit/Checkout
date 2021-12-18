//  Created by Jordi Dewit on 23/11/2021.
//  This will be the model for this checkout game

import Foundation

struct Store{
    
    private(set) var name: String
    private(set) var products: Array<Product>
    private(set) var productOnScreen: Product
    private(set) var productCount: Int
    private(set) var score: Int
    private(set) var payed: Double
    
    private let maxProducts: Int = 4
    
    //INITIALISER
    
    init(chosenStore storename: String, numberOfProducts: Int, createImg: (Int) -> String){
        name = storename
        score = 0
        products = []
        payed = 0
        for i in 1..<numberOfProducts+1{
            let emo: String = createImg(i)
            let price: Double = round((Double.random(in: 1..<1000)))/100
            products.append(Product(id: i, img: emo, price: price))
        }
        productOnScreen = products[0]
        productCount = 1
    }
    
    //FUNCTIONS
    
    mutating func getNextProduct(){
        let i = products.firstIndex(where: {
            $0.id == productOnScreen.id
        })!
        
        if i == 0 || i < maxProducts{
            productOnScreen = products[i+1]
            productCount += 1
        }else{
            print("We are done")
        }
    }
    
    mutating func giveMoney(payed value: Double){
        payed += value
    }
    
    mutating func pay(payed value: Double, for product: Product){
        payed = value
        if payed == product.price{
            score+=1
            print(score)
        }
        payed -= payed
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





