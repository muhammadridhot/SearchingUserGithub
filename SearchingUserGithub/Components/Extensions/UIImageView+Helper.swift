//
//  UIImageView+Helper.swift
//  TokopediaMiniProject
//
//  Created by CoffeeLatte on 12/05/22.
//

import UIKit
import Kingfisher

extension UIImageView {
    func setImage(url: String) {
        let processor = DownsamplingImageProcessor(size: CGSize(width: 100, height: 100))
                     |> RoundCornerImageProcessor(cornerRadius: 12)
        self.kf.indicatorType = .activity
        self.kf.setImage(
            with: URL(string: url),
            placeholder: UIImage(named: "placeholderImage"),
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
        {
            result in
            switch result {
            case .success(let value):
                print("Task done for: \(value.source.url?.absoluteString ?? "")")
            case .failure(let error):
                print("Job failed: \(error.localizedDescription)")
            }
        }
    }
}
