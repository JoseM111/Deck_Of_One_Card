import UIKit

class CardModelController {
    
    // MARK: _@Magic-Strings 🧙🏾‍♂️
    static let baseURL = URL(string: "https://deckofcardsapi.com/api/deck/new/draw/")
    static let count = "count"
    
    static func fetchCard(completion: @escaping (Result <Card, CardError>) -> Void) {
        
        // 1 - Prepare URL
        guard let baseURL = baseURL else { return completion(.failure(.invalidURL)) }
        var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        let countItem = URLQueryItem(name: count, value: "1")
        components?.queryItems = [countItem]
        guard let finalURL = components?.url else { return (completion(.failure(.invalidURL))) }
        
        
        // 2 - Contact server
        URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
            // 3 - Handle errors from the server
            if let error = error {
                return completion(.failure(.thrownError(error)))
            }
            
            // 4 - Check for json data
            guard let data =  data else { return completion(.failure(.noData)) }
            
            // 5 - Decode json into a Card
            do {
                let parentStruct = try JSONDecoder().decode(ParentStruct.self, from: data)
                guard let card = parentStruct.cards.first
                    else { return completion(.failure(.noData)) }
                return completion(.success(card))
            } catch {
                return completion(.failure(.thrownError(error)))
            }
            
        }.resume()
    }
    
    /**©------------------------------------------------------------------------------©*/
    // @escaping means the closure can run after the function returns. Perfect for concurrency/multi-threading.
       static func fetchImage(for card: Card, completion: @escaping (Result<UIImage, CardError>) -> Void) {
           
           // 1 - URL
           let url = card.image
           
           // 2 - Data Task
           URLSession.shared.dataTask(with: url) { data, _, error in
               
               // 3 - Error handling
               if let error = error {
                   return completion(.failure(.thrownError(error)))
               }
               
               // 4 - Check for data
               guard let data = data else { return completion(.failure(.noData)) }
               
               // 5 - "Decode" an image
               guard let image = UIImage(data: data) else { return completion(.failure(.unableToDecode)) }
               return completion(.success(image))
               
           }.resume()
        }
    /**©------------------------------------------------------------------------------©*/
}
