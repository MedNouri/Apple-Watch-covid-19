//
//  CountryDetails.swift
//  Covid Stat WatchKit Extension
//
//  Created by Mohamed Nouri  on 29/04/2020.
//  Copyright © 2020 Mohamed Nouri . All rights reserved.
//

import UIKit
import WatchKit
import Foundation


class CountryDetails: WKInterfaceController {
    
    @IBOutlet weak var countryName: WKInterfaceLabel!
    
    @IBOutlet weak var numbreTotalConfirmed: WKInterfaceLabel!
    
    var country: Country? {
      didSet {
        guard let country = country else { return }
        countryName.setText(country.slug) 
        numbreTotalConfirmed.setText(country.totalConfirmed.description)
        
      }
    }

    override func awake(withContext context: Any?) {
      super.awake(withContext: context)

      if let country = context as? Country {
        self.country = country
      }
        
    }
    
    
}
