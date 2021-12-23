//  Created by Jordi Dewit on 23/11/2021.
//  This is the viewmodel for checkout game

import Foundation
import SwiftUI


class CheckoutViewModel: ObservableObject
{
    // model with which we communicate
    @Published private var model = buildStore()
    var player: Player?
    
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
    
    func setNameAndLevel(store: String, level: Int){
        model.setNameAndLevel(storeOption: store, level: level)
    }
    
    // getter for the storename
    func getStoreName() -> String{
        return model.name!
    }
    
    // get cash (levels must be still implemented)
    func getCash() -> Array<Double>{
        return model.getCash()
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

    // adding score to scoreboard from current player
    func addScoreToScoreBoard(){
        self.player?.scores.append(self.getScore())
        Task{
            do{
                try await addScoreToPlayer()
            }catch{
                print("Error \(error)")
            }
        }
    }
    
    func addScoreToPlayer() async throws {
        let urlString = APIConstants.basicURL + Endpoints.players
        
        // make sure URL exists
        guard let url = URL(string: urlString) else {
            throw HttpError.badURL
        }
        let playerScoreToUpdate = Player(id: self.player!.id, name: self.player!.name, scores: self.player!.scores)
        try await HttpClient.shared.createData(to: url, object: playerScoreToUpdate, httpMethod: HTTPMethods.PUT.rawValue)
        
    }
    
}






