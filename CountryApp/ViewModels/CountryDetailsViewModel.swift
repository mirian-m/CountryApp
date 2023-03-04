//
//  DetailsViewModel.swift
//  MirianMaglakelidze#21
//
//  Created by Admin on 3/4/23.
//

import Foundation

final class CountryDetailsViewModel {
    let countryName: String
    let capital: String
    let population: Double
    let flag: String
    
    init(country: Country) {
        self.countryName = country.name
        self.capital = country.capital ?? ""
        self.population = country.population ?? 0
        self.flag = country.flag
    }
}

