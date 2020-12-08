import Foundation

enum SSError: Error {
    case wrongSegue(_ description: String? = nil, file: String = #file, line: Int = #line, function: String = #function)
}
