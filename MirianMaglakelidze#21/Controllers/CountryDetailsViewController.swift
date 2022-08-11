
import UIKit

class CountryDetailsViewController: UIViewController {

    @IBOutlet weak var flagImageView: UIImageView! {
        didSet {
            flagImageView.layer.cornerRadius = 10
        }
    }
    @IBOutlet weak var capitalLb: UILabel!
    @IBOutlet weak var populationLb: UILabel!
    
    var country: Country!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationBar()
        updateView()
    }
    
    func setUpNavigationBar() {
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.barStyle = .black
    }
    
    func updateView() {
        title = country.name
        capitalLb.text = country.capital
        populationLb.text = String(describing: country.population!)
        print(country.flag)
        flagImageView.getImageFromWeb(by: country.flag)
    }
}

