import UIKit
import SVGKit

extension UIImageView {

    func getImageFromWeb(by url: String) {
        guard let ApiUrl = URL(string: url) else { return }
        URLSession.shared.dataTask(with: ApiUrl) { (data, _, error) in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async {
                guard let svgImage = SVGKImage(data: data) else { return }
                    self.image = svgImage.uiImage
            }
        }.resume()
    }
}
