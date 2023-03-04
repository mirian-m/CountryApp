//
//  APiColler.swift
//  MirianMaglakelidze#21
//
//  Created by Admin on 8/11/22.
//
import UIKit
import SVGKit

enum ApiUrl {
    static let baseUrl = "https://restcountries.com/v2/all"
}

struct CountryService {
    
    static let shared = CountryService()
    
    func fetchCountries(complition: @escaping (Result<[Country], Error>) -> Void) {
        guard let url = URL(string: ApiUrl.baseUrl) else { return }
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
