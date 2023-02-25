//
//  APIServicesManager.swift
//  CoppelMovies
//
//  Created by Luis Enrique Grano on 23/02/23.
//

import Foundation


class CMAPIServicesManager {
    static let shared = CMAPIServicesManager()
    private let apiKey = "6aa86200203cd4c8453548b98506b2f7"
    private var tokenExpiration: Double = 0
    private var token = ""
    var sessionID = ""
    
    
    func request<response: Decodable>(url: String,
                                      method: CMAPIServicesRequestMethodEnum,
                                      body: Codable?,
                                      responseType: response.Type,
                                      success: @escaping (response) -> (),
                                      failure: @escaping (String)->()) {
        self.request(url: url, method: method, body: body) { responseData in
            guard let decodedResponse = try? JSONDecoder().decode(response.self, from: responseData) else {
                DispatchQueue.main.async {
                    failure(CMNetworkErrorStringsEnum.BadResponse.rawValue)
                }
                return
            }
            DispatchQueue.main.async {
                success(decodedResponse)
            }
        } failure: { error in
            DispatchQueue.main.async {
                failure(error)
            }
        }
    }
    
    func request(url: String,
                 method: CMAPIServicesRequestMethodEnum,
                 body: Codable?,
                 success: @escaping (Data) -> (),
                 failure: @escaping (String)->()) {
        guard let keyURL = self.getURLWithKey(url: url) else {
            DispatchQueue.main.async {
                failure(CMNetworkErrorStringsEnum.BadURL.rawValue)
            }
            return
        }

        var request = URLRequest(url: keyURL)
        request.httpMethod = method.rawValue
        
        
        if let nonNilBody = body {
            request.setValue(CMHeadersStringsEnum.ContentType.getDefaultValue(), forHTTPHeaderField: CMHeadersStringsEnum.ContentType.rawValue)
            
            guard let bodyData = try? JSONEncoder().encode(nonNilBody) else {
                DispatchQueue.main.async {
                    failure(CMNetworkErrorStringsEnum.BadBody.rawValue)
                }
                return
            }
            request.httpBody = bodyData
        }
        
        let task = URLSession.shared.dataTask(with: request) { responseData, responseURL, error in
            guard let nonNilResponseData = responseData, error == nil else {
                DispatchQueue.main.async {
                    failure(error?.localizedDescription ?? "")
                }
                return
            }
            
            DispatchQueue.main.async {
                success(nonNilResponseData)
            }
        }
        task.resume()
    }
    
    public func getToken(forceNew: Bool = false,
                         success: @escaping (String) -> (),
                         failure: @escaping (String) -> ()) {
        if !forceNew {
            guard !checkValidToken() else {
                DispatchQueue.main.async {
                    success(self.token)
                }
                return
            }
        }
        
        
        let tokenURL = (CMAPIServicesURLBaseEnum.movie3.rawValue + CMAPIServicesURLPrefixEnum.auth.rawValue + CMAPIServicesURLEndpointEnum.token.rawValue)
        
        self.request(url: tokenURL, method: .get, body: nil, responseType: CMTokenResponse.self) { response in
            guard let newToken = response.request_token, let expiration = response.expires_at, response.success == true else {
                DispatchQueue.main.async {
                    failure(CMNetworkErrorStringsEnum.BadResponse.rawValue)
                }
                return
            }
            
            self.saveExpirationDate(date: expiration)
            self.token = newToken
            DispatchQueue.main.async {
                success(self.token)
            }
        } failure: { error in
            DispatchQueue.main.async {
                failure(error)
            }
        }
    }
    
    
    private func saveExpirationDate(date: String) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss 'UTC'"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        if let utcDate = dateFormatter.date(from: date) {
            dateFormatter.timeZone = TimeZone.current
            let localDate = dateFormatter.string(from: utcDate)
            
            tokenExpiration = (dateFormatter.date(from: localDate)?.timeIntervalSince1970 ?? 0)
        }
    }
    
    private func checkValidToken() -> Bool {
        let currentDate = Date().timeIntervalSince1970
        return currentDate < tokenExpiration
    }
    
    func appendToURLStr(url: String, queryItems: [String: String]) -> String {
        guard var urlComponents = URLComponents(string: url) else {
            return url
        }
        
        var currentQueryItems = urlComponents.queryItems ?? []
        
        for (key, value) in queryItems {
            currentQueryItems.append(URLQueryItem(name: key, value: value))
        }
        
        urlComponents.queryItems = currentQueryItems
        
        guard let nonNilURL = urlComponents.url else {
            return url
        }

        return nonNilURL.absoluteString
    }
    
    func getURLWithKey(url: String) -> URL? {
        return URL(string: self.appendToURLStr(url: url, queryItems: [CMQueryItemsStringsEnum.APIKey.rawValue: "\(self.apiKey)"]))
    }
}
