import UIKit
import Alamofire

class FeedViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var authorizationToken: SignUpToken? = nil
    var dogList: DogList? = nil
    
    var dogsImageViewsArray: [UIImageView] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let authorized = authorizationToken?.key{
            self.fetchDogs(category: "husky", tokenKey: authorized)
        }
    }
}

//MARK: Network layer functions
extension FeedViewController {
    
    fileprivate func fetchDogs(category: String, tokenKey: String){
        DogServices.fetchDogs(category: category, tokenKey: tokenKey) {
            [weak self]
            (result: Result<DogList, APIError>) -> (Void) in
            
            switch result {
            
            case .success(let dogList):
                self?.dogList = dogList
                self?.fillDogsImageViewsArray(dogList)
                
                //reload tableView with dogs pictures
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
                
            case .failure(let error):
                //TODO: treat error
                print(error)
            }
        }
    }
    
    fileprivate func fillDogsImageViewsArray(_ dogList: (DogList)) {
        for url in dogList.list{
            let imageView = UIImageView()
            imageView.insertImageFromUrl(urlAsString: url)
            self.dogsImageViewsArray.append(imageView)
        }
    }
}

extension FeedViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dogList?.list.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "DogCell", for: indexPath) as? DogCell {
            cell.dogImageView.image = dogsImageViewsArray[indexPath.row].image
            
            return cell
        }
        return UITableViewCell()
    }
}
