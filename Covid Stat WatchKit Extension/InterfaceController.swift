//
//  InterfaceController.swift
//  Covid Stat WatchKit Extension
//
//  Created by on 29/04/2020.
//  Copyright © 2020 Mohamed Nouri . All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {
    
        var DataSourceTbael: CountryCount?
    @IBOutlet weak var covideTable: WKInterfaceTable!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .decimal
        currencyFormatter.locale = Locale.current
        
        
        
        GetTableDat { (results) in
            
            DispatchQueue.main.async {
                self.covideTable.setNumberOfRows( 16, withRowType: "covidTable")
                
                
                
                guard let result = results?.global else {
                    
                    return
                }
                
                self.DataSourceTbael = results
                
                for index in 0..<6 {
                    guard let controller = self.covideTable.rowController(at: index) as? RowController else { continue }
                    
               
                    switch index {
                        
                    case 0: controller.NumbreTotal.setText( currencyFormatter.string(for: result.totalConfirmed))
                    controller.NumbreTotal.setTextColor(.redColor)
                    controller.label.setText("Total Confirmed")
                    case 1:  controller.NumbreTotal.setText( currencyFormatter.string(for: result.totalDeaths))
                    controller.NumbreTotal.setTextColor(.DeathColor)
                    controller.label.setText("Total Deaths")
                    case 2:  controller.NumbreTotal.setText( currencyFormatter.string(for: result.totalRecovered))
                    controller.NumbreTotal.setTextColor(.greenColor)
                    controller.label.setText("Total Recovered")
                    case 3: controller.NumbreTotal.setText( "↑+" + currencyFormatter.string(for: result.newConfirmed)!)
                    controller.NumbreTotal.setTextColor(.redColor)
                    controller.label.setText("New Confirmed")
                    case 4:  controller.NumbreTotal.setText( "↑+" + currencyFormatter.string(for: result.newDeaths)!)
                    controller.NumbreTotal.setTextColor(.DeathColor)
                    controller.label.setText("New Deaths")
                    case 5:  controller.NumbreTotal.setText( "↑+" + currencyFormatter.string(for: result.newRecovered)!)
                    controller.NumbreTotal.setTextColor(.greenColor)
                    controller.label.setText("New Recovered")
                        
                        
                        
                    default:
                        return
                    }
                    
                    
                }
                guard var country = results?.countries else {
                    
                    return
                }
                
                country.sort(by: {
                    $0.totalConfirmed > $1.totalConfirmed
                })
                
                for index in 0..<10 {
                    guard let controller = self.covideTable.rowController(at: index + 6) as? RowController else { continue }
                    controller.backGroundColorGroup.setBackgroundColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
                    controller.NumbreTotal.setText( currencyFormatter.string(for: country[index ].totalConfirmed))
                    controller.NumbreTotal.setTextColor(.redColor)
                    controller.label.setText(country[index ].slug)
                    
                    
                    
                }
                
                
                
                
                
                
                
                // settig UP date
                
                let dateFormatterGet = DateFormatter()
                dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd MMMM"
                
                let date: Date? = dateFormatterGet.date(from: results?.date ?? "" )
                if let date = date{
                    dateFormatter.dateFormat =  "HH:mm"
                    self.setTitle( dateFormatter.string(from: date))
                    
                }
                
                
                
                
                
            }
            
        }
        
        // Configure interface objects here.
    }
    
    
    
    
    
    

    
    
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
  
    
    override func table(_ table: WKInterfaceTable, didSelectRowAt rowIndex: Int) {
        
        let country = DataSourceTbael?.countries[rowIndex]
        presentController(withName: "Details", context: country)
        
        
    }
    
    
}



extension InterfaceController {
    
    
    
    
    
    
    func GetTableDat( completionHandler: @escaping (CountryCount?) -> Void){
        var request = URLRequest(url: URL(string: "https://api.covid19api.com/summary")!,timeoutInterval: Double.infinity)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                completionHandler(nil)
                
                return
            }
            
            // print(String(data: data, encoding: .utf8))
            do {
                var res = try JSONDecoder().decode(CountryCount.self, from: data)
                
                res.countries.removeAll(where: { (countrey) -> Bool in
                    countrey.totalConfirmed == 0 && countrey.totalDeaths == 0
                })
                
                res.countries.sort(by: {
                    $0.totalConfirmed > $1.totalConfirmed
                })
                
                
                completionHandler(res)
                
                
                
            } catch let error {
                completionHandler(nil)
                print(error)
            }
            
            
        }
        
        task.resume()
        
    }
    
    
    
    
}
