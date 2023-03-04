
import UIKit

final class CountryDetailsViewController: UIViewController {

    @IBOutlet weak var flagImageView: UIImageView! {
        didSet {
            flagImageView.layer.cornerRadius = 10
        }
    }
    @IBOutlet weak var capitalLb: UILabel!
    @IBOutlet weak var populationLb: UILabel!
    
    var viewModel: CountryDetailsViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationBar()
        updateView()
    }
    
    private func setUpNavigationBar() {
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.barStyle = .black
    }
    
    private func updateView() {
        if viewModel != nil {
            title = viewModel!.countryName
            populationLb.text = String(describing: viewModel!.population)
            capitalLb.text = viewModel!.capital
            flagImageView.getImageFromWeb(by: viewModel!.flag)
        }
    }
}

