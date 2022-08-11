//
//  APiColler.swift
//  MirianMaglakelidze#21
//
//  Created by Admin on 8/11/22.
//
import UIKit
import SVGKit

struct Constants {
    static let countryUrlStr = "https://restcountries.com/v2/all"
}

struct APIColler {
    static let shared = APIColler()
    
    func fetchCountries(complition: @escaping (Result<[Country], Error>) -> Void) {
        guard let url = URL(string: Constants.countryUrlStr) else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else { return }
            do {
                let country = try JSONDecoder().decode([Country].self, from: data)
                complition(.success(country))
            } catch {
                complition(.failure(error))
            }
        }.resume()
    }
}
