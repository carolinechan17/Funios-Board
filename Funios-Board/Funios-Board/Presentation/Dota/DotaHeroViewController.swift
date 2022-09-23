//
//  DotaHeroViewController.swift
//  Funios-Board
//
//  Created by Caroline Chan on 23/09/22.
//

import UIKit

class DotaHeroViewController: UIViewController {

    @IBOutlet weak var dotaHeroTableView: UITableView!
    
    var dotaHeroData: [DotaModel] = []
    var dotaServices: DotaServices = DotaServices()
    var storage: UserDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if dotaHeroData.isEmpty {
            
        } else {
            
        }
    }

}

//MARK: Delegate
extension DotaHeroViewController {
    func setupDelegate() {
        self.dotaHeroTableView.dataSource = self
        self.dotaHeroTableView.delegate = self
    }
}

//MARK: Fetch data from API
extension DotaHeroViewController {
    func getHeroFromApi() async {
        do {
            let data = try await dotaServices.getHero(endPoint: .getHero)
            
            //MARK: After successfully fetched data, store data into UserDefaults
            
        } catch {
            print(error)
        }
    }
}

//MARK: UserDefaults to store data locally
extension DotaHeroViewController {
    func setDataToLocal<T: Codable>(object: T, with key: String, usingEncoder encoder: JSONEncoder = JSONEncoder()) {
        let data = try? encoder.encode(object)
        UserDefaults.standard.set(data, forKey: key)
    }
    
    func getDataFromLocal<T: Codable>(_ type: T.Type, with key: String, usingDecoder decoder: JSONDecoder = JSONDecoder()) -> T? {
        guard let data = self.value(forKey: key) as? Data else {return nil}
        return try? decoder.decode(type.self, from: data)
    }
}

//MARK: Conform UITableViewDelegate and UITableViewDataSource
extension DotaHeroViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dotaHeroData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
