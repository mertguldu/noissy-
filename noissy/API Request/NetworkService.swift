//
//  NetworkService.swift
//  noissy

import Foundation

struct NetworkService {
    
    static let shared = NetworkService()
    private init() {}
    
    func myFirstRequest(completion: @escaping (Result<String, Error>) -> Void) {
        request(route: .temp, method: .get, completion: completion)
    }
    
    private func request<T: Decodable>(route: Route, method: Method, parameters: [String: Any]? = nil, completion: @escaping (Result<T, Error>) -> Void) {
        
        guard let request = createRequest(route: route, method: method, parameters: parameters) else { return }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            var result: Result<Data, Error>?
            if let data = data {
                result = .success(data)
                let respondString = String(data: data, encoding: .utf8) ?? "Could not convert data to string"
                print("response is:", respondString)
            } else if let error = error {
                result = .failure(error)
                print(error.localizedDescription)
            }
            
            DispatchQueue.main.async {
                // decode the result and send it back to the user
                self.handleResponse(result: result, completion: completion)
            }
        }.resume()
    }
    
    private func handleResponse<T: Decodable>(result: Result<Data, Error>?, completion: (Result<T, Error>) -> Void) {
        guard let result = result else {
            completion(.failure(AppError.unkownError))
            return
        }
        
        switch result {
            
        case .success(let data):
            let decoder = JSONDecoder()
            guard let response = try? decoder.decode(APIResponse<T>.self, from: data) else {
                completion(.failure(AppError.errorDecoding))
                return
            }
            
            if let error = response.error {
                completion(.failure(AppError.serverError(error)))
                return
            }
            
            if let decodedMusicData = response.musicData {
                completion(.success(decodedMusicData))
            } else {
                completion(.failure(AppError.unkownError))
            }
            
        case .failure(let error):
            completion(.failure(error))
        }
    }
    
    
    /// generate a urlReuquest
    /// - Parameters:
    ///   - route: the path to the resource in the backend
    ///   - method: type of request to be made
    ///   - parameters: extra info needed to pass to the backend
    /// - Returns: URLRequest
    private func createRequest(route: Route,
                               method: Method,
                               parameters: [String: Any]? = nil) -> URLRequest? {
        let urlString = Route.baseUrl + route.description // basURL + endpoint: "https://.../temp"
        guard let url = urlString.asUrl else { return nil }
        var urlRequest = URLRequest(url: url)
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpMethod = method.rawValue
        
        if let params = parameters {
            switch method {
            case .get:
                var urlCompenent = URLComponents(string: urlString)
                urlCompenent?.queryItems = params.map { URLQueryItem(name: $0, value: "\($1)")}
                urlRequest.url = urlCompenent?.url
    
            case .post, .delete, .patch:
                let bodyData = try? JSONSerialization.data(withJSONObject: params, options: [])
                urlRequest.httpBody = bodyData
            }
        }
        return urlRequest
    }
}

extension String {
    var asUrl: URL? {
        return URL(string: self)
    }
}
