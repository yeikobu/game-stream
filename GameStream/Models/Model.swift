//
//  Model.swift
//  GameStream
//
//  Created by Jacob Aguilar on 28-01-22.
//

import Foundation

struct Games: Codable {
    
    var games: [Game]
}

struct Game: Codable, Hashable {
    
    var title: String
    var studio: String
    var contentRaiting: String
    var publicationYear: String
    var description: String
    var platforms: [String]
    var tags: [String]
    var videosUrls: VideoUrl //Por cada json de la api, hay que modelarlo con codable
    var galleryImages: [String]
}

struct VideoUrl: Codable, Hashable {
    
    var mobile: String
    var tablet: String
}

struct Results: Codable { //Estructura para los resultados de las busquedas
    
    var results: [Game]
}
