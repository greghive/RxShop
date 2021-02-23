//
//  XiblessViewController.swift
//  RxShop
//
//  Created by Greg Price on 23/02/2021.
//

import UIKit

// reference: https://padraig.org/appkit/2020/10/25/layout-in-code.html

class XiblessViewController<V: UIView>: UIViewController {
    
    var contentView: V {
        return view as! V
    }
    
    override func loadView() {
        view = V(frame: .zero)
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
