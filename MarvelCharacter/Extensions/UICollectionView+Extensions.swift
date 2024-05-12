//
//  UICollectionView+Extensions.swift
//  MarvelCharacter
//
//  Created by Hellen Caroline  on 01/05/24.
//

import UIKit

extension UICollectionView {

    func setupEmptyView() {
        self.backgroundView = EmptyAgentView()
    }

    func removeBackGroundView() {
        let emptyView = UIView(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, 
                                             height: self.bounds.size.height))
        emptyView.backgroundColor = .white
        
        self.backgroundView = emptyView
    }
}
