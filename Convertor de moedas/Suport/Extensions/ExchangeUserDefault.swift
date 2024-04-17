//
//  UserDefault.swift
//  Convertor de moedas
//
//  Created by Kekoi Lima on 16/04/24.
//

import Foundation


class ExchangeUserDefault {
    
    let kHistory = "kHistory"
    
    public func save (listCoins:[Coin]) {
        do{
            let list = try JSONEncoder().encode(listCoins)
            UserDefaults.standard.setValue(list, forKey: self.kHistory)
        }catch{
            print(error)
        }
    }
    public func getListCoins() ->[Coin]{
        do{
            guard let list = UserDefaults.standard.object(forKey: self.kHistory) else{ return []}
            let listAux = try JSONDecoder().decode([Coin].self, from: list as! Data)
        }catch{
            print(error)
        }
        return []
    }
    
}
