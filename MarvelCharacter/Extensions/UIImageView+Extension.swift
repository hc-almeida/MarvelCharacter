//
//  UIImageView+Extension.swift
//  MarvelCharacter
//
//  Created by Hellen Caroline  on 02/05/24.
//

import Foundation
import UIKit

extension UIImageView {
    func addImageFromURL(url: String) {
        guard let url = URL(string: url) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) -> Void in
            if error == nil {
                DispatchQueue.main.async {
                    self.image = UIImage(data: data!)
                }
            }
        }.resume()
    }
}
