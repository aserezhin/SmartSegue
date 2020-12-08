import UIKit

open class SetRootSegue: Segue {

    // MARK: - ModuleSegueProtocol

    public func go(
        from source: ModuleTransition,
        to destination: ModuleTransition,
        animate: Bool,
        completion: EmptyClosure?
    ) throws {
        switch (source, destination) {
        case (let source as UINavigationController, let destination as UIViewController):
            try self.setRoot(from: source, to: destination, animate: animate, completion: completion)
        case (let source as UIViewController, let destination as UIViewController):
            try self.setRoot(from: source.navigationController, to: destination, animate: animate, completion: completion)
        default:
            throw SSError.wrongSegue()
        }
    }

    public func goBack(animate: Bool, completion: EmptyClosure?) { }
}

// MARK: - Set root from UIViewController to UIViewControllers

private extension SetRootSegue {
    func setRoot(
        from source: UINavigationController?,
        to destination: UIViewController,
        animate: Bool,
        completion: EmptyClosure?
    ) throws {
        if let navigationController = source {
            navigationController.setViewControllers([destination], animated: animate)
        } else {
            UIApplication.shared.windows.first?.rootViewController = destination
        }
        completion?()
    }
}
