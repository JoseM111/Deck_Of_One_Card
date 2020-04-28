import Foundation

// MARK: @ParentStruct
struct ParentStruct: Decodable {
    
    // MARK: @Properties
    var cards: [Card]
}

/**©-----------------------------©*/
// MARK: @ChildStruct
   struct Card: Decodable {
       
       // MARK: @Properties
       var value: String
       var suit: String
       var image: URL
   }
/**©-----------------------------©*/
