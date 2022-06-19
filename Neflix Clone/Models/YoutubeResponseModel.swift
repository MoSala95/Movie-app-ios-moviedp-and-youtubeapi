//
//  YoutubeResponseModel.swift
//  Neflix Clone
//
//  Created by mohamed salah on 18/06/2022.
//

import Foundation

 

struct YoutubeResponse : Codable{
    let items : [VideoItems]
}

struct VideoItems : Codable {
    let id : VideoItemId
}

struct VideoItemId : Codable {
    let videoId :String
}
