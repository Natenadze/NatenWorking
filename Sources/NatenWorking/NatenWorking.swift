// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

public enum NetworkError: Error {
    case invalidURL
    case noData
    case badResponse
}

public final class NetworkManager {
    
    @available(iOS 13.0.0, *)
    public func performURLRequest<T: Decodable>(_ urlString: String) async throws -> T? {
        guard let url = URL(string: urlString) else { throw NetworkError.invalidURL }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        guard (response as? HTTPURLResponse)?.statusCode  == 200 else { throw NetworkError.badResponse }
        
        let decoder = JSONDecoder()
        let result = try decoder.decode(T.self, from: data)
        return result
    }
}

