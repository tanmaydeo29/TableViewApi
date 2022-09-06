//
//  ViewController.swift
//  ApiJson
//
//  Created by Tanmay Deo on 05/09/22.
//

import UIKit
import Kingfisher

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var myArray : [Users] = [Users]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        parseJson()
    }
    
    func parseJson(){
        let urlString = "https://dummyjson.com/users"
        let url = URL(string: urlString)!
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url, completionHandler: {(Data , UIResponder , Error) in
            if(Error != nil){
                print(Error!)
            }
            if let safedata = Data{
                let decoder = JSONDecoder()
                do{
                    let parsingData = try decoder.decode(JsonData.self, from: safedata)
                    self.myArray = parsingData.users
                    
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
                catch{
                    print("Parsing Error")
                }
            }
        })
        task.resume()
    }
}


extension ViewController : UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellTB", for: indexPath) as! TableViewCell
        cell.nameLabel.text = myArray[indexPath.row].firstName
        cell.emailLabel.text = myArray[indexPath.row].email
        let imageUrl = URL(string: myArray[indexPath.row].image)
        cell.profileImage.kf.setImage(with: imageUrl)
        return cell
    }
}

