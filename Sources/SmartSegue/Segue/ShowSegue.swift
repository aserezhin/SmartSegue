import UIKit

open class ShowSegue: Segue {

    // MARK: - Private propeties

    private weak var destination: ModuleTransition?

    // MARK: - Public properties

    public let identifer: String?

    // MARK: - Initialization

    public init(identifer: String? = nil) {
        self.identifer = identifer
    }

    // MARK: - ModuleSegueProtocol

    public func go(
        from source: ModuleTransition,
        to destination: ModuleTransition,
        animate: Bool,
        completion: EmptyClosure?
    ) throws {
        self.destination = destination

        switch (source, destination) {
        case (let source as ViewTransition, let destination as UIView):
            self.show(from: source, to: destination, animate: animate, completion: completion)
        case (let source as UIViewController, let destination as UIViewController):
            self.show(from: source, to: destination, animate: animate, completion: completion)
        default:
            throw SSError.wrongSegue()
        }

    }

    public func goBack(animate: Bool, completion: EmptyClosure?) throws {
        switch self.destination {
        case let destination as UIViewController:
            self.goBack(from: destination, animate: animate, completion: completion)
        default:
            throw SSError.wrongSegue()
        }
    }
}

// MARK: - Show from UIViewController to UIViewController

private extension ShowSegue {
    func show(
        from source: UIViewController,
        to destination: UIViewController,
        animate: Bool,
        completion: EmptyClosure?
    ) {
        source.navigationController?.pushViewController(destination, animated: animate)
        completion?()
    }

    func goBack(from source: UIViewController, animate: Bool, completion: EmptyClosure?) {
        source.navigationController?.popViewController(animated: animate)
        completion?()
    }
}

// MARK: - Show from ViewTransition to UIView

private extension ShowSegue {
    func show(from source: ViewTransition, to destination: UIView, animate: Bool, completion: EmptyClosure?) {
        let containerView = source.provideContainerView(by: self.identifer)
        destination.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(destination)
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: destination.leadingAnchor),
            containerView.topAnchor.constraint(equalTo: destination.topAnchor),
            containerView.trailingAnchor.constraint(equalTo: destination.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: destination.bottomAnchor)
        ])
        completion?()
    }

    func goBack(from source: ViewTransition, animate: Bool, completion: EmptyClosure?) {
        let containerView = source.provideContainerView(by: self.identifer)
        containerView.subviews.forEach { $0.removeFromSuperview() }
        completion?()
    }
}
