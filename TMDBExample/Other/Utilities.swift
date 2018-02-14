//
//  Utilities.swift
//  TMDBExample
//
//  Created by ss on 09/02/2018.
//  Copyright © 2018 ss. All rights reserved.
//

import Foundation
import UIKit

protocol Nameable {}

extension Nameable {
    static var name: String {
        return String(describing: self)
    }
}

protocol NibGettable: Nameable {}

extension NibGettable {
    static var nib: UINib {
        return UINib(nibName: name, bundle: nil)
    }
}

func asyncMain(cl: @escaping () -> Void) {
    DispatchQueue.main.async {
        cl()
    }
}

func asyncGlobal(cl: @escaping () -> Void) {
    DispatchQueue.global().async {
        cl()
    }
}
