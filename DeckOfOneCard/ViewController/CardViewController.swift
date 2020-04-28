import UIKit

class CardViewController: UIViewController {
    
    // MARK: _@IBOutlet
    @IBOutlet weak var cardLabel: UILabel!
    @IBOutlet weak var cardImgView: UIImageView!
    @IBOutlet weak var btnToStyle: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Adding border radius to button 'Draw'
        btnToStyle.layer.cornerRadius = 13
    }
    
    // MARK: _@IBAction
    @IBAction func drawButtonTapped(_ sender: Any) {
        
        CardModelController.fetchCard { [weak self] (result) in
            DispatchQueue.main.async {
                
                switch result {
                    case .success(let card):
                        self?.fetchImageAndUpdateView(with: card)
                    case .failure(let error):
                        self?.presentErrorToUser(localizedError: error)
                }
            }
        }
    }
    
    // MARK: _@Methods
    /**©------------------------------------------------------------------------------©*/
    func fetchImageAndUpdateView(with card: Card) {
           
           CardModelController.fetchImage(for: card) { [weak self] (result) in
               
               DispatchQueue.main.async {
                   switch result {
                       case .success(let image):
                           self?.cardLabel.text = "\(card.value) of \(card.suit)"
                           self?.cardImgView.image = image
                       case .failure(let error):
                           self?.presentErrorToUser(localizedError: error)
                   }
               }
           }
       }
    /**©------------------------------------------------------------------------------©*/
}
