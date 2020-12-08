import UIKit

public protocol ModuleTransition: class {
    var showedSegue: Segue? { get set }

    func perform(module: ModuleTransition, segue: Segue, animate: Bool, completion: EmptyClosure?) throws
    func close(animate: Bool, segue: Segue?, completion: EmptyClosure?) throws
}

// MARK: - Default implementation

extension ModuleTransition {
    func perform(module: ModuleTransition, segue: Segue, animate: Bool, completion: EmptyClosure?) throws {
        module.showedSegue = segue
        try segue.go(from: self, to: module, animate: animate, completion: completion)
    }

    func close(animate: Bool, segue: Segue?, completion: EmptyClosure?) throws {
        let closeSegue = segue ?? self.showedSegue
        try closeSegue?.goBack(animate: animate, completion: completion)
    }
}
