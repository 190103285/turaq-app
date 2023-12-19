//
//  UITableViewCell+ReusableCell.swift
//  TuraqApp
//
//  Created by Akyl on 01.03.2023.
//

import UIKit

public extension ReusableCell where Self: UITableViewCell {
    static var identifier: String {
        return NSStringFromClass(self).components(separatedBy: .punctuationCharacters).last ?? ""
    }
    
    var identifier: String {
        return (type(of: self)).identifier
    }
    
    static func reusable(for tableView: UITableView, indexPath: IndexPath) -> Self {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: self.identifier, for: indexPath) as? Self else {
            preconditionFailure("Catch exeption on reuse cell \(identifier)")
        }
        return cell
    }
    
    static func register(for tableView: UITableView) {
        tableView.register(Self.self, forCellReuseIdentifier: self.identifier)
    }
    
    static func registerNibInstance(for tableView: UITableView) {
        let nib = UINib(nibName: self.identifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: self.identifier)
    }
}
