import UIKit

final class CountriesViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var CountryTableView: UITableView!
    
    private let viewModel: CountryViewModel = CountryViewModel()
    
    //  MARK:- ViewController life Cicle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViewController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(true)
        navigationController?.navigationBar.isHidden = true
    }
    
    //  MARK:- Private Functions
    private func setUpViewController() {
        searchBar.delegate = self
        CountryTableView.delegate = self
        CountryTableView.dataSource = self
        CountryTableView.register(CountryNameTableViewCell.self, forCellReuseIdentifier: CountryNameTableViewCell.identifier)
        viewModel.fetchCountriesData()
        bind()
    }
    
    private func bind() {
        viewModel.countriesName.bind { _ in
            self.updateView()
        }
    }
    
    private func updateView() {
        DispatchQueue.main.async { [weak self] in
            self?.CountryTableView.reloadData()
        }
    }
}

//  MARK:- extension

extension CountriesViewController: UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate  {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.countriesName.value?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CountryNameTableViewCell.identifier, for: indexPath) as? CountryNameTableViewCell
        else { return UITableViewCell() }
        
        if viewModel.countriesName.value != nil {
            cell.configure(with: (viewModel.countriesName.value?[indexPath.row]))
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "CountryDetailsViewController") as? CountryDetailsViewController
        else { return }
        
        guard let selectedCountryName = viewModel.countriesName.value?[indexPath.row].countryName else { return }
        guard let selectedCountryDetails = viewModel.getCountryDetails(by: selectedCountryName) else { return }
        vc.viewModel = CountryDetailsViewModel(country: selectedCountryDetails)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        50
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let query = searchBar.text else { return }
        viewModel.searchCountry(by: query)
    }
}
