//
//  CountryModel.swift
//  MirianMaglakelidze#21
//
//  Created by Admin on 8/11/22.
//

import Foundation
import UIKit

struct Country: Codable {
    let name: String
    let capital: String?
    let region: String
    let population: Double?
    let area: Double?
    let flag: String
}
