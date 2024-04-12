//
//  NetworkService.swift
//  noissy

import Foundation

struct NetworkService {
    
    static let shared = NetworkService()
    private init() {}

    func sendVideoData(videoData: String, userID: String, completion: @escaping (Result<APIResponse, Error>) -> Void) {
        let params = ["VideoData": videoData, "UserID": userID]
        request(route: .temp, method: .post, parameters: params, completion: completion)
    }
    
    private func request(route: Route, method: Method, parameters: [String: Any]? = nil, completion: @escaping (Result<APIResponse, Error>) -> Void) {
        
        guard let request = createRequest(route: route, method: method, parameters: parameters) else { return }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            var result: Result<Data, Error>?
            if let data = data {
                result = .success(data)
                //let respondString = String(data: data, encoding: .utf8) ?? "Could not convert data to string"
            } else if let error = error {
                result = .failure(error)
            }
            
            DispatchQueue.main.async {
                // decode the result and send it back to the user
                self.handleResponse(result: result, completion: completion)
            }
        }.resume()
    }
    
    private func handleResponse(result: Result<Data, Error>?, completion: (Result<APIResponse, Error>) -> Void) {
        guard let result = result else {
            completion(.failure(AppError.unkownError))
            return
        }
        
        switch result {
            
        case .success(let data):
            let decoder = JSONDecoder()
            guard let response = try? decoder.decode(APIResponse.self, from: data) else {
                completion(.failure(AppError.errorDecoding))
                return
            }
            
            if let error = response.error {
                completion(.failure(AppError.serverError(error)))
                return
            }
            
            completion(.success(response))
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
        
        // Set timeout interval (adjust the value as needed)
        urlRequest.timeoutInterval = 150.0 //seconds
        
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
