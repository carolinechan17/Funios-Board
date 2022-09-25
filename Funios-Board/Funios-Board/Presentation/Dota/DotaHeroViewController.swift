//
//  DotaHeroViewController.swift
//  Funios-Board
//
//  Created by Caroline Chan on 23/09/22.
//

import UIKit

class DotaHeroViewController: UIViewController {
    
    @IBOutlet weak var heroTableView: UITableView!
    
    var heroData: DotaModel = []
    var dotaServices: DotaServices = DotaServices()
    var storage: UserDefaults = UserDefaults.standard
    
    var agi: DotaModel = []
    var int: DotaModel = []
    var str: DotaModel = []
    var classifiedHero: [DotaModel] = []
    
    var headers: [String] = ["Agi", "Int", "Str"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let _ = getDataFromLocal(DotaModel.self, with: "heroData") else {
            Task {
                heroData = await getHeroFromApi() ?? []
                classifyHero(data: heroData)
            }
            return
        }
        
        heroData = getDataFromLocal(DotaModel.self, with: "heroData") ?? []
        classifyHero(data: heroData)
        
        setupDelegate()
    }

}

//MARK: Delegate
extension DotaHeroViewController {
    func setupDelegate() {
        self.heroTableView.dataSource = self
        self.heroTableView.delegate = self
        self.heroTableView.register(UINib(nibName: "DotaHeroTableViewCell", bundle: nil), forCellReuseIdentifier: "DotaCell")
    }
}

//MARK: Function to classify hero by their primary attribute
extension DotaHeroViewController {
    func classifyHero(data: DotaModel) {
        for item in data {
            switch item.primaryAttr {
            case "agi":
                agi.append(item)
            case "str":
                str.append(item)
            case "int":
                int.append(item)
            default:
                continue
            }
        }
        
        classifiedHero.append(agi)
        classifiedHero.append(int)
        classifiedHero.append(str)
    }
}

//MARK: Fetch data from API
extension DotaHeroViewController {
    func getHeroFromApi() async -> DotaModel?{
        let data = try? await dotaServices.getHero(endPoint: .getHero)
        
        //MARK: After successfully fetched data, set data to local
        setDataToLocal(object: data, with: "heroData")
        return data
    }
}

//MARK: UserDefaults to store data locally
extension DotaHeroViewController {
    func setDataToLocal<T: Codable>(object: T, with key: String, usingEncoder encoder: JSONEncoder = JSONEncoder()) {
        let data = try? encoder.encode(object)
        UserDefaults.standard.set(data, forKey: key)
    }
    
    func getDataFromLocal<T: Codable>(_ type: T.Type, with key: String, usingDecoder decoder: JSONDecoder = JSONDecoder()) -> T? {
        guard let data = UserDefaults.standard.value(forKey: key) as? Data else {return nil}
        return try? decoder.decode(type.self, from: data)
    }
}

//MARK: Table View for Agi Hero
extension DotaHeroViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return headers[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return agi.count
        case 1:
            return int.count
        case 2:
            return str.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = heroTableView.dequeueReusableCell(withIdentifier: "DotaCell") as? DotaHeroTableViewCell else {
            return UITableViewCell()
        }
        
        let hero = classifiedHero[indexPath.section][indexPath.row]
        cell.setupData(heroName: hero.localizedName)
        return cell
    }
}
