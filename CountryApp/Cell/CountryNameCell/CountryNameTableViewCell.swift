import UIKit

class CountryNameTableViewCell: UITableViewCell {
    static let identifier = "CountryNameTableViewCell"
    
    var countryNameLb: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(countryNameLb)
        self.accessoryType = .detailDisclosureButton
        adjustConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func adjustConstraints() {
        let countryNameLbConstraints = [
            countryNameLb.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            countryNameLb.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            countryNameLb.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20)
        ]
        
        NSLayoutConstraint.activate(countryNameLbConstraints)
    }

    func configure(with countryName: CountryTableViewCellViewModel?) {
        countryNameLb.text = countryName?.countryName ?? ""
    }
}
