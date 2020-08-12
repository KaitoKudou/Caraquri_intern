import UIKit

final class APIClient {
    // swiftlint:disable cyclomatic_complexity
    // swiftlint:disable function_body_length
    static func fetchEvents(keyword: String,
                            completion: @escaping(Result<[Event], ErrorType>) -> Void ) {
        
        var urlComps = URLComponents(string: "https://connpass.com/api/v1/event")!
        let queryItems = [URLQueryItem(name: "count", value: "20"),
        URLQueryItem(name: "keyword", value: keyword)]
        urlComps.queryItems = queryItems
        
        let session = URLSession(configuration: .default)
        guard let url = urlComps.url else { return }
        let request = URLRequest(url: url)
        
        Logger.printRequest(request: request)
        let task = session.dataTask(with: request, completionHandler: {data, response, error in
            if error != nil {
                completion(.failure(ErrorType.offline))
            }
            // ステータスコードによるエラーハンドリング
            guard let response = response as? HTTPURLResponse else { return }
            
            do {
                switch response.statusCode {
                case 200..<300:
                    break
                    
                case 400:
                    throw ErrorType.invalidParams
                    
                case 401:
                    throw ErrorType.unauthorized
                    
                case 403:
                    throw ErrorType.forbidden
                    
                case 404:
                    throw ErrorType.notFound

                case 500:
                    throw ErrorType.serverError
                    
                default:
                    throw ErrorType.unKnown
                }
                
            } catch {
                guard let error = error as? ErrorType else { return }
                Logger.printError(error: error)
                completion(.failure(error))
            }
            
            // デコードによるエラーハンドリング
            guard let data = data else { return }
            Logger.prettyPrint(data: data)

            do {
                let response = try JSONDecoder().decode(Events.self, from: data)
                completion(.success(response.events))
                
            } catch {
                Logger.printError(error: ErrorType.decode)
                completion(.failure(ErrorType.decode))
            }
        })
        task.resume()
    }
}
