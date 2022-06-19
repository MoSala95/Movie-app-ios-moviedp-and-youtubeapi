//
//  APICaller.swift
//  Neflix Clone
//
//  Created by mohamed salah on 04/06/2022.
//

import Foundation

struct Constants{
    static let API_KEY = "a440e15542a61f82164da5dd2e5600a1"
    static let baseURL = "https://api.themoviedb.org"
    
    static let YouTubeApiKey = "AIzaSyA521KzsTDp6eJpC489Q8l4sLcEW-eYGgY"
    static let youtubeBaseUrl = "https://youtube.googleapis.com/youtube/v3"

}

enum APIError : Error {
    case failedToGetData
}
class ApiCaller{
    static let shared = ApiCaller()
    
    func getTrendingMovies(completion : @escaping (Result<[Title], Error>) -> Void){
        guard let url = URL(string: "\(Constants.baseURL)/3/trending/movie/day?api_key=\(Constants.API_KEY)") else{return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url), completionHandler: {
            data, _,error in
               guard let data = data ,error==nil else{
                   return
               }
   
               do{
                    let result = try JSONDecoder().decode(TitleResponse.self, from: data)
                   completion(.success(result.results))
                   print (result)
                   
               }catch{
                   completion(.failure(error))
                   print(error.localizedDescription)
               }
        })
        
        task.resume()
    }
    func getTrendingTv(completion : @escaping (Result<[Title], Error>) -> Void){
        guard let url = URL(string: "\(Constants.baseURL)/3/trending/tv/day?api_key=\(Constants.API_KEY)") else{return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url), completionHandler: {
            data, _,error in
               guard let data = data ,error==nil else{
                   return
               }
   
               do{
                    let result = try JSONDecoder().decode(TitleResponse.self, from: data)
                   completion(.success(result.results))
                   print (result)
                   
               }catch{
                   completion(.failure(error))
                   print(error.localizedDescription)
               }
        })
        
        task.resume()
    }
    
    func getUpcomingMovies(completion : @escaping (Result<[Title], Error>) -> Void){
        guard let url = URL(string: "\(Constants.baseURL)/3/movie/upcoming?api_key=\(Constants.API_KEY)") else{return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url), completionHandler: {
            data, _,error in
               guard let data = data ,error==nil else{
                   return
               }
   
               do{
                    let result = try JSONDecoder().decode(TitleResponse.self, from: data)
                   completion(.success(result.results))
                   print (result)
                   
               }catch{
                   completion(.failure(error))
                   print(error.localizedDescription)
               }
        })
        
        task.resume()
    }
    func getPopular(completion : @escaping (Result<[Title], Error>)->Void){
        guard let url = URL(string: "\(Constants.baseURL)/3/movie/popular?api_key=\(Constants.API_KEY)") else{return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url), completionHandler: {
            data, _,error in
               guard let data = data ,error==nil else{
                   return
               }
   
               do{
                    let result = try JSONDecoder().decode(TitleResponse.self, from: data)
                   completion(.success(result.results))
                   print (result)
                   
               }catch{
                   completion(.failure(error))
                   print(error.localizedDescription)
               }
        })
        
        task.resume()
    }
    
    func getTopRated(completion : @escaping (Result<[Title], Error>)->Void){
        guard let url = URL(string: "\(Constants.baseURL)/3/movie/top_rated?api_key=\(Constants.API_KEY)") else{return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url), completionHandler: {
            data, _,error in
               guard let data = data ,error==nil else{
                   return
               }
   
               do{
                    let result = try JSONDecoder().decode(TitleResponse.self, from: data)
                   completion(.success(result.results))
                   print (result)
                   
               }catch{
                   completion(.failure(error))
                   print(error.localizedDescription)
               }
        })
        
        task.resume()
    }
   
    func getDiscover(completion : @escaping (Result<[Title], Error>)->Void){
        guard let url = URL(string: "\(Constants.baseURL)/3/discover/movie?api_key=\(Constants.API_KEY)&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_watch_monetization_types=flatrate") else{return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url), completionHandler: {
            data, _,error in
               guard let data = data ,error==nil else{
                   return
               }
   
               do{
                    let result = try JSONDecoder().decode(TitleResponse.self, from: data)
                   completion(.success(result.results))
                   print (result)
                   
               }catch{
                   completion(.failure(error))
                   print(error.localizedDescription)
               }
        })
        
        task.resume()
    }
    
    func search (query:String , completion : @escaping (Result<[Title], Error>)->Void){
        

        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        guard let url = URL(string: "\(Constants.baseURL)/3/search/movie?api_key=\(Constants.API_KEY)&query=\(query)") else{return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url), completionHandler: {
            data, _,error in
               guard let data = data ,error==nil else{
                   return
               }
   
               do{
                    let result = try JSONDecoder().decode(TitleResponse.self, from: data)
                   completion(.success(result.results))
                   print (result)
                   
               }catch{
                   completion(.failure(error))
                   print(error.localizedDescription)
               }
        })
        
        task.resume()
    }
    
    func getYoutubeTrailer(query : String , completion : @escaping (Result<YoutubeResponse,Error>)->Void){
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        
        guard let url = URL(string: "\(Constants.youtubeBaseUrl)/search?q=\(query)&key=\(Constants.YouTubeApiKey)") else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url), completionHandler: {
            data , _ ,error in
            guard let data = data , error==nil else{return}
            
            do{
                let response = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                print(response)
                let result = try JSONDecoder().decode(YoutubeResponse.self, from: data)
                completion(.success(result))
            }catch{
                completion(.failure(error))
                print(error.localizedDescription)
            }
        })
        
        task.resume()
    }
}
