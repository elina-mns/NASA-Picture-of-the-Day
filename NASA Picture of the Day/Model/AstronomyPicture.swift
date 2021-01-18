//
//  AstronomyPicture.swift
//  NASA Picture of the Day
//
//  Created by Elina Mansurova on 2021-01-18.
//

import Foundation

struct AstronomyPicture: Codable {
    let explanation: String
    let hdurl: URL
    let mediaType: UIImage
    let title: String
}

