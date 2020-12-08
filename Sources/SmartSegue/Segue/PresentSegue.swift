import UIKit

class PresentSegue: Segue {

    // MARK: - Private propeties

    private weak var destination: ModuleTransition?

    // MARK: - ModuleSegueProtocol

    func go(
        from source: ModuleTransition,
        to destination: ModuleTransition,
        animate: Bool,
        completion: EmptyClosure?
    ) throws {
        self.destination = destination

        switch (source, destination) {
        case (let source as UIViewController, let destination as UIViewController):
            self.present(from: source, to: destination, animate: animate, completion: completion)
        default:
            throw SSError.wrongSegue()
        }
    }

    func goBack(animate: Bool, completion: EmptyClosure?) throws {
        switch self.destination {
        case let destination as UIViewController:
            self.goBack(from: destination, animate: animate, completion: completion)
        default:
            throw SSError.wrongSegue()
        }
    }
}

// MARK: - Present from UIViewController to UIViewController

private extension PresentSegue {
    func present(
        from source: UIViewController,
        to destination: UIViewController,
        animate: Bool,
        completion: EmptyClosure?
    ) {
        source.present(destination, animated: animate, completion: completion)
    }

    func goBack(from source: UIViewController, animate: Bool, completion: EmptyClosure?) {
        source.dismiss(animated: animate, completion: completion)
    }
}
