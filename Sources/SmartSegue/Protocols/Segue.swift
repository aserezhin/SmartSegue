import Foundation

public protocol Segue {
    func go(
        from source: ModuleTransition,
        to destination: ModuleTransition,
        animate: Bool,
        completion: EmptyClosure?
    ) throws
    func goBack(animate: Bool, completion: EmptyClosure?) throws
}

