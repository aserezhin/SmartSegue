import UIKit

public protocol ViewTransition {
    func provideContainerView(by identifer: String?) -> UIView
}
