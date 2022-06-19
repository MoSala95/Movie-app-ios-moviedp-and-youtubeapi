// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let trendingResponse = try? newJSONDecoder().decode(TrendingResponse.self, from: jsonData)

import Foundation

// MARK: - TrendingResponse
struct TitleResponse: Codable {
    let page: Int
    let results: [Title]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Result
struct Title: Codable {
    let name: String?
    let id: Int
    let originalName: String?
    let originCountry: [String]?
    let voteCount: Int
    let firstAirDate: String?
    let backdropPath: String
    let posterPath: String?
    let voteAverage: Double
    let genreIDS: [Int]
    let overview: String
    let popularity: Double
    let adult: Bool?
    let originalTitle, releaseDate, title: String?
    let video: Bool?

    enum CodingKeys: String, CodingKey {
        case name, id
        case originalName = "original_name"
        case originCountry = "origin_country"
         case voteCount = "vote_count"
        case firstAirDate = "first_air_date"
        case backdropPath = "backdrop_path"
        case posterPath = "poster_path"
        case voteAverage = "vote_average"
        case genreIDS = "genre_ids"
        case overview, popularity
        case adult
        case originalTitle = "original_title"
        case releaseDate = "release_date"
        case title, video
    }
}


 
