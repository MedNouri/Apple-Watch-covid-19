//
//  CountryCount.swift
//  Covid Stat WatchKit Extension
//
//  Created by Mohamed Nouri  on 02/05/2020.
//  Copyright © 2020 Mohamed Nouri . All rights reserved.
//

import Foundation
struct CountryCount: Codable {
    let global:Country
    var countries: [Country]
    let date: String
    
    enum CodingKeys: String, CodingKey {
        case countries = "Countries"
        case date = "Date"
        case global = "Global"
    }
}

// MARK: - Country
struct Country: Codable {
    let country, slug: String?
    var newConfirmed, totalConfirmed, newDeaths, totalDeaths: Int
    let newRecovered, totalRecovered: Int
    
    
    enum CodingKeys: String, CodingKey {
        case country = "Country"
        case slug = "Slug"
        
        
        case newConfirmed = "NewConfirmed"
        case totalConfirmed = "TotalConfirmed"
        case newDeaths = "NewDeaths"
        case totalDeaths = "TotalDeaths"
        
        case newRecovered = "NewRecovered"
        case totalRecovered = "TotalRecovered"
    }
    
    
}
struct Global: Codable {
    let newConfirmed, totalConfirmed, newDeaths, totalDeaths: Int
    let newRecovered, totalRecovered: Int
    
    enum CodingKeys: String, CodingKey {
        case newConfirmed = "NewConfirmed"
        case totalConfirmed = "TotalConfirmed"
        case newDeaths = "NewDeaths"
        case totalDeaths = "TotalDeaths"
        case newRecovered = "NewRecovered"
        case totalRecovered = "TotalRecovered"
    }
}


struct Number {
    static let withSeparator: NumberFormatter = {
        let formatter = NumberFormatter()
        //  formatter.groupingSeparator = ","
        //   formatter.usesGroupingSeparator = true
        //  formatter.numberStyle = .decimal
        //formatter.locale = Locale.current
        return formatter
    }()
}
extension Int {
    var stringWithSepator: String {
        return self.hashValue.description
    }
}
