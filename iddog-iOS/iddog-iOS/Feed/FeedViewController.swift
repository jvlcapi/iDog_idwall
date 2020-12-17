import UIKit
import Alamofire

class FeedViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var dogList: DogList? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fetchDogs(category: "husky")
    }
}

//MARK: Network layer calls
extension FeedViewController {
    fileprivate func fetchDogs(category: String){
        DogServices.fetchDogs(category: category) { [weak self] (result: Result<DogList, APIError>) -> (Void) in
            
            switch result {
            
            case .success(let dogList):
                self?.dogList = dogList
                
            case .failure(let error):
                //TODO: treat error
                print(error)
                
            }
        }
    }
}

extension FeedViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dogList?.list.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "DogCell", for: indexPath) as? DogCell {
            
            
            return cell
        }
        return UITableViewCell()
    }
}
