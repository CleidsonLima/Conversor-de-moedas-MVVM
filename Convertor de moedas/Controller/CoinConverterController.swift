//
//  CoinConverterController.swift
//  Convertor de moedas
//
//  Created by Kekoi Lima on 15/04/24.
//

import UIKit
import iOSDropDown

class CoinConverterController: UIViewController{
    
    //MARK: IBOutlets
    @IBOutlet weak var dropDownTo: DropDown!
    @IBOutlet weak var dropDownFrom: DropDown!
    @IBOutlet weak var lblValueConvert: UILabel!
    @IBOutlet weak var txtValueInfo: UITextField!
    
    
    //MARK: Private vars/lets
    private var coinUsed:Coin?
    var keyToExchange:String = String.empty()
    var keyFromExchange:String = String.empty()
    
    
    //MARK: ViewModel
    private var viewModel: CoinConverterViewModel!
    
    //MARK: Life Cycle
    override func viewDidLoad(){
        super.viewDidLoad()
        self.viewModel = CoinConverterViewModel()
        
        self.configDropDown()
    
        
        }
    //MARK: @IBAction
    
    @IBAction func actGetCoin(_ sender: UIButton) {
        let error:String = self.validateFields()
        if error != String.empty(){
            self.view.showMessege(view: self, messsege: error)
        }else{
            let param1 = self.dropDownTo.text!
            let param2 = self.dropDownFrom.text!
//            
//            self.keyToExchange = param1 + param2
//            self.keyFromExchange = param2 + param1
//            
            let param:String = "\(param1)-\(param2)"
            self.getCoins(param: param)
        }
    }
    
    @IBAction func saveHistory(_ sender: UIButton) {
        let error:String = self.validateFields()
        if error != String.empty(){
            self.view.showMessege(view: self, messsege: error)
        }else{
            if let coin = self.coinUsed {
                self.viewModel.saveHistoryExchange(coin: coin){ message in
                    self.view.showMessege(view: self, messsege: message)
                    
                }
            }else{
                self.view.showMessege(view: self, messsege: "voce precisa primeiro fazer a conversao para salvar")
            }
        }
    }
    // MARK: Private Funcs
    
    private func validateFields() -> String{
        
        var error:String = String.empty()
        
            if self.txtValueInfo.text == String.empty() {
                error = "Informe o valor a ser convertido"
                
            }else if self.dropDownTo.text == String.empty() || self.dropDownFrom.text == String.empty() {
                error = "selecione as moedas para serem convertidas"
                
            }else if self.dropDownTo.text == self.dropDownFrom.text{
                error = "Selecione moedas diferentes"
            }
            
            return error
            
        }
    
    private func getCoins(param:String){
        self.viewModel.getCoins(params: param){(data, error) in
            if let coins = data {
                DispatchQueue.main.async{
                    let valueStr:NSNumber = self.viewModel.calculateCoins(valueInfo: self.txtValueInfo.text!, valueCoin: self.coinUsed!.buyValue)
                    self.lblValueConvert.text = String().formatCurrency(value: valueStr, enumCoin: self.dropDownFrom.text!)
                }
            }else{
                
            }
        }
    }
    
    private func configDropDown(){
        self.dropDownTo.optionArray = self.viewModel.getListCoins()
        self.dropDownTo.arrowSize = 5
        self.dropDownTo.selectedRowColor = .gray
        
        self.dropDownFrom.optionArray = self.viewModel.getListCoins()
        self.dropDownFrom.arrowSize = 5
        self.dropDownFrom.selectedRowColor = .gray
    }
    
    
}
