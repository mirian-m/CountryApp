//
//  CountryViewModel.swift
//  MirianMaglakelidze#21
//
//  Created by Admin on 3/2/23.
//

import Foundation

final class CountryViewModel {
    var countriesName: ObservableObject<[CountryTableViewCellViewModel]> = ObservableObject([])
    private var countriesData: [Country] = []
    
    //  Get country Data
    func fetchCountriesData() {
        CountryService.shared.fetchCountries { [weak self ] result in
            switch result {
            case .success(let countreis):
                self?.countriesData = countreis
                self?.countriesName.value = self?.countriesData.map({ CountryTableViewCellViewModel(countryName: $0.name) })
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension CountryViewModel {
    func getCountryDetails(by countryName: String) -> Country? {
        countriesData.filter ({ $0.name == countryName }).first 
    }
    
    func searchCountry(by query: String) {
        if !query.trimmingCharacters(in: .whitespaces).isEmpty {
            let filterdCountries = countriesData.filter { $0.name.lowercased().starts(with: query.lowercased()) }
            countriesName.value = filterdCountries.map({ CountryTableViewCellViewModel(countryName: $0.name) })
            return
        }
        countriesName.value = countriesData.map({ CountryTableViewCellViewModel(countryName: $0.name) })
    }
}

struct CountryTableViewCellViewModel {
    var countryName: String
}

