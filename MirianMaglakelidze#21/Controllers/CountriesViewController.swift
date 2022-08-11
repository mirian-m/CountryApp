import UIKit

class CountriesViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var CountryTableView: UITableView! {
        didSet {
//            CountryTableView.backgroundColor = .black
            CountryTableView.register(CountryNameTableViewCell.self, forCellReuseIdentifier: CountryNameTableViewCell.identifier)
        }
    }

    private var countries: [Country] = []
    private var filteredCountries: [Country] = []

    private var filtered: Bool = false {
        didSet {
            CountryTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViewController()
        getCountries()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(true)
        navigationController?.navigationBar.isHidden = true
    }
    
    func setUpViewController() {
        searchBar.delegate = self
        CountryTableView.delegate = self
        CountryTableView.dataSource = self
    }
    
    private func getCountries() {
        APIColler.shared.fetchCountries { [weak self] result in
            switch result {
            case .success(let countryArray):
                self?.countries = countryArray
                self?.updateView()
            case .failure(let error):
                print(error)
            }
        }
    }

   private func updateView() {
        DispatchQueue.main.async { [weak self] in
            self?.CountryTableView.reloadData()
        }
    }
}

extension CountriesViewController: UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate  {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filtered ? filteredCountries.count : countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CountryNameTableViewCell.identifier, for: indexPath) as? CountryNameTableViewCell else { return UITableViewCell() }
        filtered ? cell.configure(with: filteredCountries[indexPath.row]) : cell.configure(with: countries[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "CountryDetailsViewController") as? CountryDetailsViewController else { return }
        filtered ? (vc.country = filteredCountries[indexPath.row]) : (vc.country = countries[indexPath.row])
        self.navigationController?.pushViewController(vc, animated: true)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        50
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let query = searchBar.text,
              !query.trimmingCharacters(in: .whitespaces).isEmpty
        else {
            filtered = false
            return
        }
        filteredCountries = countries.filter { $0.name.lowercased().starts(with: query.lowercased()) }
        filtered = true
    }
}
