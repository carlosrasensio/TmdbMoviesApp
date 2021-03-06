//
//  NetworkManager.swift
//  TmdbMoviesApp
//
//  Created by crodrigueza on 9/11/21.
//

import Foundation
import RxSwift

class NetworkManager {
    func getMovies() -> Observable<[Movie]>  {
        return Observable.create { observer -> Disposable in
            let url = URL(string: Constants.NetworkManager.URLs.base  + Constants.NetworkManager.Endpoints.popularMovies + Constants.NetworkManager.Endpoints.apiKey)!
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.addValue("application/json", forHTTPHeaderField: "Content-type")
            let session = URLSession.shared
            let task = session.dataTask(with: request) { (data, response, error) in
                guard let data = data, error == nil, let response = response as? HTTPURLResponse else { return }
                if response.statusCode == 200 {
                    do {
                        let decoder = JSONDecoder()
                        let searchedMovies = try decoder.decode(Movies.self, from: data)

                        observer.onNext(searchedMovies.movies)
                    } catch let error {
                        print("\n[X] Error: \(error.localizedDescription)\n")
                    }
                } else if response.statusCode == 400 {
                    print("\n[X] Error: 401\n")
                }
                observer.onCompleted()
            }
            task.resume()

            return Disposables.create {
                session.finishTasksAndInvalidate()
            }
        }
    }
}
