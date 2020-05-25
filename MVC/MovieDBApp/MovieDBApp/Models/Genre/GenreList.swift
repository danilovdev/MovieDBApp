//
//  GenreList.swift
//  MovieDBApp
//
//  Created by Aleksei Danilov on 25.05.2020.
//  Copyright © 2020 DanilovDev. All rights reserved.
//

import Foundation

struct GenreList: Decodable {
    
    let genres: [Genre]
    
    init() {
        genres = []
    }
}
