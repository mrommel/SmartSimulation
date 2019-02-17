//
//  UITableViewExtension.swift
//  Simulation
//
//  Created by Michael Rommel on 16.02.19.
//  Copyright © 2019 Michael Rommel. All rights reserved.
//

import UIKit

public protocol DequeuableProtocol: class {
    
    /// Return the nib name in which the dequeuable resource is located
    /// You must implement it if your cell is located in a separate xib file
    /// (not for storyboard).
    /// In this case you should call `table.register(CellClass.self)` before
    /// using it in your code.
    /// Default implementation returns the name of the class itself.
    static var dequeueNibName: String { get }
    
    /// This is the identifier used to queue/dequeue the cell.
    /// You don't need to override it; default implementation return the name
    /// of the cell class itself as identifier.
    static var dequeueIdentifier: String { get }
}

extension DequeuableProtocol where Self: UIView {
    public static var dequeueIdentifier: String {
        return NSStringFromClass(self)
    }
    public static var dequeueNibName: String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
}

extension UITableView {
    
    public func register<T: UITableViewCell>(_: T.Type) where T: DequeuableProtocol {
        let bundle = Bundle(for: T.self)
        let nib = UINib(nibName: T.dequeueNibName, bundle: bundle)
        self.register(nib, forCellReuseIdentifier: T.dequeueIdentifier)
    }
    
    public func dequeueReusableCell<T: UITableViewCell>(forIndexPath indexPath: IndexPath) -> T where T: DequeuableProtocol {
        guard let cell = dequeueReusableCell(withIdentifier: T.dequeueIdentifier, for: indexPath) as? T else {
            fatalError("Cannot dequeue: \(T.self) with identifier: \(T.dequeueIdentifier)")
        }
        return cell
    }
}
