

import UIKit

// ref: adapted from https://www.hackingwithswift.com/articles/71/how-to-use-the-coordinator-pattern-in-ios-apps

protocol Storyboarded {
    static var storyboard: Storyboard { get }
    static func fromStoryboard() -> Self
}

extension Storyboarded where Self: UIViewController {
    static func fromStoryboard() -> Self {
        let fullName = NSStringFromClass(self)
        let className = fullName.components(separatedBy: ".")[1]
        let aStoryboard = UIStoryboard(name: storyboard.rawValue, bundle: Bundle.main)
        return aStoryboard.instantiateViewController(withIdentifier: className) as! Self
    }
}

